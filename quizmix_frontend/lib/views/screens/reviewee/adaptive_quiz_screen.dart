import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/quizzes/cat_family_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/cat_specs_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_taken_quiz_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewee_details_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_answer_quiz/answer_quiz_item.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class AdaptiveQuizScreen extends ConsumerStatefulWidget {
  AdaptiveQuizScreen({Key? key}) : super(key: key);

  @override
  _AdaptiveQuizScreenState createState() => _AdaptiveQuizScreenState();
}

class _AdaptiveQuizScreenState extends ConsumerState<AdaptiveQuizScreen> {
  int currentQuestionIndex = 0;
  bool allQuestionsAnswered = false;
  bool hasInit = false;

  void itemAnalysisAndScoring(
    WidgetRef ref,
    int revieweeId,
    bool isCurrentAnswerCorrect,
    Question currentQuestion,
  ) {
    final Map<String, int> resp = {
      "reviewee": revieweeId,
      "question": currentQuestion.id,
      "response": isCurrentAnswerCorrect ? 1 : 0,
    };

    // let our notifier know that a change in the api has occured
    final notifier = ref.read(revieweeProvider.notifier);
    notifier.updateReviewee(ref, resp);
  }

  void handleChoicePressed(String choice, Question currentQuestion) {
    // Check if the current answer is correct
    bool isCurrentAnswerCorrect = currentQuestion.answer == choice;
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

    itemAnalysisAndScoring(
        ref, revieweeId!, isCurrentAnswerCorrect, currentQuestion);

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
                  'Your score is ${ref.read(currentTakenQuizProvider.notifier).score}'),
              actions: <Widget>[
                SolidButton(
                  text: 'OK',
                  onPressed: () {
                    ref.read(currentTakenQuizProvider.notifier).updateScore(0);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
        return;
      } else {
        // decrement category from specs
        ref.read(catSpecsProvider.notifier).updateSpecs();

        // proceed to next question
        currentQuestionIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuiz = ref.watch(currentTakenQuizProvider);
    final currentQuestion = ref.watch(catFamilyProvider(currentQuestionIndex));

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
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Answer Adaptive Quiz',
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
                        currentQuestion != null
                            ? AnswerQuizItem(
                                question: currentQuestion.question,
                                image: currentQuestion.image!,
                                choices: currentQuestion.choices,
                                allQuestionsAnswered: allQuestionsAnswered,
                              )
                            : const SizedBox(),
                        allQuestionsAnswered == true
                            ? const Spacer()
                            : const SizedBox(),
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            Expanded(
                              child: SolidButton(
                                onPressed: () =>
                                    handleChoicePressed('a', currentQuestion!),
                                isUnpressable: allQuestionsAnswered,
                                text: 'Choice A',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SolidButton(
                                onPressed: () =>
                                    handleChoicePressed('b', currentQuestion!),
                                isUnpressable: allQuestionsAnswered,
                                text: 'Choice B',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SolidButton(
                                onPressed: () =>
                                    handleChoicePressed('c', currentQuestion!),
                                isUnpressable: allQuestionsAnswered,
                                text: 'Choice C',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SolidButton(
                                onPressed: () =>
                                    handleChoicePressed('d', currentQuestion!),
                                isUnpressable: allQuestionsAnswered,
                                text: 'Choice D',
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
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
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double gridWidth = constraints.maxWidth * 0.1;
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 70,
                              crossAxisSpacing: 12.0,
                              mainAxisSpacing: 12.0,
                            ),
                            itemCount: currentQuiz.questions.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: gridWidth,
                                child: Column(
                                  children: [
                                    Material(
                                      color: Colors.transparent,
                                      child: GestureDetector(
                                        onTap:
                                            () {}, // No action on tap, making it non-pressable
                                        child: Container(
                                          width: gridWidth,
                                          height: gridWidth,
                                          color: allQuestionsAnswered
                                              ? const Color.fromARGB(
                                                  115, 158, 158, 158)
                                              : currentQuestionIndex == index
                                                  ? AppColors.mainColor
                                                  : currentQuestionIndex > index
                                                      ? const Color.fromARGB(
                                                          115, 158, 158, 158)
                                                      : AppColors.thirdColor,
                                          child: Center(
                                            child: Text(
                                              '${index + 1}',
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01,
                                                color: allQuestionsAnswered ||
                                                        currentQuestionIndex ==
                                                            index
                                                    ? Colors.white
                                                    : currentQuestionIndex >
                                                            index
                                                        ? Colors.white
                                                        : AppColors.mainColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
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
