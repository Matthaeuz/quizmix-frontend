import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/question_attempts/question_details.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/current_quiz_attempted_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/reviewee_attempts_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/cat_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_taken_quiz_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_answer_quiz/answer_quiz_item.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_answer_quiz/answer_quiz_number.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class AnswerQuizScreen extends ConsumerStatefulWidget {
  const AnswerQuizScreen({Key? key}) : super(key: key);

  @override
  AnswerQuizScreenState createState() => AnswerQuizScreenState();
}

class AnswerQuizScreenState extends ConsumerState<AnswerQuizScreen> {
  int currentQuestionIndex = 0;
  bool allQuestionsAnswered = false;

  void itemAnalysisAndScoring(
    WidgetRef ref,
    int revieweeId,
    bool isCurrentAnswerCorrect,
    Question? currentQuestion,
  ) {
    final Map<String, int> resp = {
      "reviewee": revieweeId,
      "question": currentQuestion == null
          ? ref
              .read(currentTakenQuizProvider)
              .questions[currentQuestionIndex]
              .id
          : currentQuestion.id,
      "response": isCurrentAnswerCorrect ? 1 : 0,
    };

    // let our notifier know that a change in the api has occured
    ref.read(userProvider.notifier).updateReviewee(ref, resp);
  }

  void endQuiz() async {
    final client = ref.read(restClientProvider);
    final token = ref.read(authTokenProvider).accessToken;
    final time = DateTime.now().toUtc();
    final quizAttempt = ref.read(currentQuizAttemptedProvider);
    final reviewee = ref.read(userProvider);

    Map<String, dynamic> timeFinished = {
      "time_finished": time.toIso8601String()
    };
    final updatedAttempt =
        await client.updateQuizAttempt(token, timeFinished, quizAttempt.id);

    ref
        .read(currentQuizAttemptedProvider.notifier)
        .updateCurrentQuizAttempted(updatedAttempt, null);
    ref
        .read(revieweeAttemptsProvider(quizAttempt.quiz.id).notifier)
        .fetchRevieweeAttempts(reviewee.id, quizAttempt.quiz.id);
  }

  void handleChoicePressed(String choice, Question? currentQuestion) async {
    final currentTakenQuiz = ref.read(currentTakenQuizProvider);

    Question question;
    if (currentQuestion != null) {
      question = currentQuestion;
      if (currentQuestionIndex <
          ref.read(currentTakenQuizProvider).questions.length - 1) {
        // temporarily set question to null if CAT and not last question
        ref.read(catProvider.notifier).setLoading();
      }
    } else {
      question = currentTakenQuiz.questions[currentQuestionIndex];
    }

    // create QuestionAttempt
    final questionDetails = QuestionDetails(
        attempt: ref.read(currentQuizAttemptedProvider).id,
        question: question.id,
        revieweeAnswer: choice,
        difficultyScore: 0);

    final client = ref.read(restClientProvider);
    final token = ref.read(authTokenProvider).accessToken;

    await client.createQuestionAttempt(token, questionDetails);

    // Check if the current answer is correct
    bool isCurrentAnswerCorrect = currentQuestion == null
        ? ref
                .read(currentTakenQuizProvider)
                .questions[currentQuestionIndex]
                .answer ==
            choice
        : currentQuestion.answer == choice;

    final reviewee = ref.read(userProvider);

    if (isCurrentAnswerCorrect) {
      ref
          .read(currentTakenQuizProvider.notifier)
          .updateScore(++ref.read(currentTakenQuizProvider.notifier).score);
    }

    itemAnalysisAndScoring(
        ref, reviewee.id, isCurrentAnswerCorrect, currentQuestion);

    setState(() {
      if (currentQuestionIndex >= currentTakenQuiz.questions.length - 1) {
        allQuestionsAnswered = true;
      } else {
        if (currentQuestion != null) {
          // decrement category from specs
          ref.read(catProvider.notifier).getNextQuestion();
        }
        // proceed to next question
        currentQuestionIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPretest =
        ref.watch(currentQuizAttemptedProvider.notifier).attemptNum == 1
            ? true
            : false;
    final currentQuiz = ref.watch(currentTakenQuizProvider);
    final currentQuestion = isPretest
        ? currentQuiz.questions[currentQuestionIndex]
        : ref.watch(catProvider).when(
              data: (data) {
                return data["question"];
              },
              error: (err, st) {},
              loading: () {},
            );
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: AppColors.mainColor,
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: AnswerQuizItem(
                        question: currentQuestion,
                        currentQuestionIndex: currentQuestionIndex,
                        allQuestionsAnswered: allQuestionsAnswered,
                        isPretest: isPretest,
                        onEnd: () => endQuiz(),
                      ),
                    ),
                  ),
                  screenHeight > 200
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                          child: Row(
                            children: [
                              Expanded(
                                child: SolidButton(
                                  text: 'A',
                                  elevation: 8.0,
                                  isUnpressable: allQuestionsAnswered ||
                                      currentQuestion == null,
                                  onPressed: () {
                                    handleChoicePressed('a',
                                        isPretest ? currentQuestion! : null);
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SolidButton(
                                  text: 'B',
                                  elevation: 8.0,
                                  isUnpressable: allQuestionsAnswered ||
                                      currentQuestion == null,
                                  onPressed: () {
                                    handleChoicePressed('b',
                                        !isPretest ? currentQuestion! : null);
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SolidButton(
                                  text: 'C',
                                  elevation: 8.0,
                                  isUnpressable: allQuestionsAnswered ||
                                      currentQuestion == null,
                                  onPressed: () {
                                    handleChoicePressed('c',
                                        !isPretest ? currentQuestion! : null);
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SolidButton(
                                  text: 'D',
                                  elevation: 8.0,
                                  isUnpressable: allQuestionsAnswered ||
                                      currentQuestion == null,
                                  onPressed: () {
                                    handleChoicePressed('d',
                                        !isPretest ? currentQuestion! : null);
                                  },
                                ),
                              )
                            ],
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 24, 24),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (int i = 0;
                                  i < currentQuiz.questions.length;
                                  i++) ...[
                                AnswerQuizNumber(
                                  number: i + 1,
                                  currentNumber: currentQuestionIndex + 1,
                                )
                              ]
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    // return Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.transparent,
    //     elevation: 0,
    //     leading: IconButton(
    //       icon: const Icon(
    //         Icons.arrow_back,
    //         color: Colors.black,
    //       ),
    //       onPressed: () {
    //         endQuiz();
    //         Navigator.pop(context);
    //       },
    //     ),
    //     title: Text(
    //       widget.isPretest ? 'Answer Quiz' : 'Answer Adaptive Quiz',
    //       style: const TextStyle(
    //         color: Colors.black,
    //         fontFamily: 'Poppins',
    //       ),
    //     ),
    //   ),
    //   body: Padding(
    //     padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
    //     child: Column(
    //       children: [
    //         Expanded(
    //           flex: 10,
    //           child: Row(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               // Left side
    //               Expanded(
    //                 flex: 10,
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     currentQuestion != null
    //                         ? AnswerQuizItem(
    //                             question: currentQuestion.question,
    //                             image: currentQuestion.image,
    //                             choices: currentQuestion.choices,
    //                             allQuestionsAnswered: allQuestionsAnswered,
    //                           )
    //                         : Expanded(
    //                             child: Container(
    //                               decoration: BoxDecoration(
    //                                 border: Border.all(
    //                                   color: AppColors.mainColor,
    //                                   width: 1,
    //                                 ),
    //                                 color: Colors.white,
    //                               ),
    //                               child: const Center(
    //                                 child: CircularProgressIndicator(),
    //                               ),
    //                             ),
    //                           ),
    //                     allQuestionsAnswered == true
    //                         ? const Spacer()
    //                         : const SizedBox(),
    //                     const SizedBox(height: 25),
    //                     Row(
    //                       children: [
    //                         Expanded(
    //                           child: SolidButton(
    //                             onPressed: () => handleChoicePressed(
    //                                 'a',
    //                                 !widget.isPretest
    //                                     ? currentQuestion!
    //                                     : null),
    //                             isUnpressable: allQuestionsAnswered ||
    //                                 currentQuestion == null,
    //                             text: 'Choice A',
    //                           ),
    //                         ),
    //                         const SizedBox(width: 12),
    //                         Expanded(
    //                           child: SolidButton(
    //                             onPressed: () => handleChoicePressed(
    //                                 'b',
    //                                 !widget.isPretest
    //                                     ? currentQuestion!
    //                                     : null),
    //                             isUnpressable: allQuestionsAnswered ||
    //                                 currentQuestion == null,
    //                             text: 'Choice B',
    //                           ),
    //                         ),
    //                         const SizedBox(width: 12),
    //                         Expanded(
    //                           child: SolidButton(
    //                             onPressed: () => handleChoicePressed(
    //                                 'c',
    //                                 !widget.isPretest
    //                                     ? currentQuestion!
    //                                     : null),
    //                             isUnpressable: allQuestionsAnswered ||
    //                                 currentQuestion == null,
    //                             text: 'Choice C',
    //                           ),
    //                         ),
    //                         const SizedBox(width: 12),
    //                         Expanded(
    //                           child: SolidButton(
    //                             onPressed: () => handleChoicePressed(
    //                                 'd',
    //                                 !widget.isPretest
    //                                     ? currentQuestion!
    //                                     : null),
    //                             isUnpressable: allQuestionsAnswered ||
    //                                 currentQuestion == null,
    //                             text: 'Choice D',
    //                           ),
    //                         )
    //                       ],
    //                     )
    //                   ],
    //                 ),
    //               ),
    //               const SizedBox(width: 25),
    //               // Right Side
    //               Expanded(
    //                 flex: 3,
    //                 child: Container(
    //                   decoration: BoxDecoration(
    //                     border: Border.all(
    //                       color: AppColors.mainColor,
    //                       width: 1.0,
    //                     ),
    //                     color: Colors.white,
    //                   ),
    //                   padding: const EdgeInsets.fromLTRB(12, 12, 12, 3),
    //                   child: Expanded(
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: [
    //                         Expanded(
    //                           child: SingleChildScrollView(
    //                             child: Wrap(
    //                               children: [
    //                                 for (int i = 0;
    //                                     i < currentQuiz.questions.length;
    //                                     i++) ...[
    //                                   AnswerQuizNumber(
    //                                     number: i + 1,
    //                                     currentNumber: currentQuestionIndex + 1,
    //                                     allQuestionsAnswered:
    //                                         allQuestionsAnswered,
    //                                   )
    //                                 ]
    //                               ],
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               )
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
