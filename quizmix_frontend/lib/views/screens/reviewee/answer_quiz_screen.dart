import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/question_attempts/question_details.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/current_quiz_attempted_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/reviewee_attempts_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_taken_quiz_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewee_details_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewee/view_quiz_result_screen.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_answer_quiz/answer_quiz_item.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_answer_quiz/answer_quiz_number.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class AnswerQuizScreen extends ConsumerStatefulWidget {
  AnswerQuizScreen({Key? key}) : super(key: key);

  @override
  _AnswerQuizScreenState createState() => _AnswerQuizScreenState();
}

class _AnswerQuizScreenState extends ConsumerState<AnswerQuizScreen> {
  int currentQuestionIndex = 0;
  bool allQuestionsAnswered = false;

  void itemAnalysisAndScoring(
    WidgetRef ref,
    int revieweeId,
    bool isCurrentAnswerCorrect,
  ) {
    final Map<String, int> resp = {
      "reviewee": revieweeId,
      "question":
          ref.read(currentTakenQuizProvider).questions[currentQuestionIndex].id,
      "response": isCurrentAnswerCorrect ? 1 : 0,
    };

    // let our notifier know that a change in the api has occured
    final notifier = ref.read(revieweeProvider.notifier);
    notifier.updateReviewee(ref, resp);
  }

  void endQuiz() async {
    final client = ref.read(restClientProvider);
    final token = ref.read(authTokenProvider).accessToken;
    final time = DateTime.now().toUtc();
    final quizId = ref.read(currentQuizAttemptedProvider).quiz.id;
    final revieweeId = ref.read(revieweeProvider).when(
          data: (data) => data.id,
          error: (err, st) => 0,
          loading: () => 0,
        );

    Map<String, dynamic> timeFinished = {
      "time_finished": time.toIso8601String()
    };
    await client.updateQuizAttempt(
        token, timeFinished, ref.read(currentQuizAttemptedProvider).id);

    ref
        .read(revieweeAttemptsProvider(quizId).notifier)
        .fetchRevieweeAttempts(revieweeId, quizId);
  }

  void handleChoicePressed(String choice) async {
    final questionDetails = QuestionDetails(
        attempt: ref.read(currentQuizAttemptedProvider).id,
        question: ref
            .read(currentTakenQuizProvider)
            .questions[currentQuestionIndex]
            .id,
        revieweeAnswer: choice,
        difficultyScore: 0);

    final client = ref.read(restClientProvider);
    final token = ref.read(authTokenProvider).accessToken;

    await client.createQuestionAttempt(token, questionDetails);

    // Check if the current answer is correct
    bool isCurrentAnswerCorrect = ref
            .read(currentTakenQuizProvider)
            .questions[currentQuestionIndex]
            .answer ==
        choice;

    final revieweeId = ref.read(revieweeProvider).when(
          data: (data) {
            return data.id;
          },
          error: (err, st) {},
          loading: () {},
        );

    if (isCurrentAnswerCorrect) {
      ref
          .read(currentTakenQuizProvider.notifier)
          .updateScore(++ref.read(currentTakenQuizProvider.notifier).score);
    }

    itemAnalysisAndScoring(ref, revieweeId!, isCurrentAnswerCorrect);

    setState(() {
      if (currentQuestionIndex >=
          ref.read(currentTakenQuizProvider).questions.length - 1) {
        allQuestionsAnswered = true;

        // Display total score
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Quiz Completed!'),
              content: Text(
                  'Your score is ${ref.read(currentTakenQuizProvider.notifier).score}/${ref.read(currentTakenQuizProvider).questions.length}'),
              actions: <Widget>[
                SolidButton(
                  text: 'Review',
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ViewQuizResultScreen(),
                      ),
                    );
                  },
                ),
                SolidButton(
                  text: 'Finish',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
        endQuiz();
        return;
      } else {
        // proceed to next question
        currentQuestionIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuiz = ref.watch(currentTakenQuizProvider);
    final currentQuestion = currentQuiz.questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            endQuiz();
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Answer Quiz',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnswerQuizItem(
                          question: currentQuestion.question,
                          image: currentQuestion.image,
                          choices: currentQuestion.choices,
                          allQuestionsAnswered: allQuestionsAnswered,
                        ),
                        allQuestionsAnswered == true
                            ? const Spacer()
                            : const SizedBox(),
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            Expanded(
                              child: SolidButton(
                                onPressed: () => handleChoicePressed('a'),
                                isUnpressable: allQuestionsAnswered,
                                text: 'Choice A',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SolidButton(
                                onPressed: () => handleChoicePressed('b'),
                                isUnpressable: allQuestionsAnswered,
                                text: 'Choice B',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SolidButton(
                                onPressed: () => handleChoicePressed('c'),
                                isUnpressable: allQuestionsAnswered,
                                text: 'Choice C',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SolidButton(
                                onPressed: () => handleChoicePressed('d'),
                                isUnpressable: allQuestionsAnswered,
                                text: 'Choice D',
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 25),
                  // Right Side
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.mainColor,
                          width: 1.0,
                        ),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 3),
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Wrap(
                                  children: [
                                    for (int i = 0;
                                        i < currentQuiz.questions.length;
                                        i++) ...[
                                      AnswerQuizNumber(
                                        number: i + 1,
                                        currentNumber: currentQuestionIndex + 1,
                                        allQuestionsAnswered:
                                            allQuestionsAnswered,
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
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
