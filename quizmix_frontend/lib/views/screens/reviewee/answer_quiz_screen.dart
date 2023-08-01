import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_taken_quiz_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_answer_quiz/answer_quiz_item.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class AnswerQuizScreen extends ConsumerStatefulWidget {
  AnswerQuizScreen({Key? key}) : super(key: key);

  @override
  _AnswerQuizScreenState createState() => _AnswerQuizScreenState();
}

class _AnswerQuizScreenState extends ConsumerState<AnswerQuizScreen> {
  int currentQuestionIndex = 0;
  bool allQuestionsAnswered = false;

  void handleChoicePressed(String choice) {
    setState(() {
      if (currentQuestionIndex >=
          ref.read(currentTakenQuizProvider).questions.length - 1) {
        allQuestionsAnswered = true;
        // Check if the last answer is correct
        if (ref
                .read(currentTakenQuizProvider)
                .questions[currentQuestionIndex]
                .answer ==
            choice) {
          ref
              .read(currentTakenQuizProvider.notifier)
              .updateScore(++ref.read(currentTakenQuizProvider.notifier).score);
        }
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
        // Check if the current answer is correct
        if (ref
                .read(currentTakenQuizProvider)
                .questions[currentQuestionIndex]
                .answer ==
            choice) {
          ref
              .read(currentTakenQuizProvider.notifier)
              .updateScore(++ref.read(currentTakenQuizProvider.notifier).score);
        }
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
                          image: currentQuestion.image!,
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
            // Expanded(
            //   flex: 1,
            //   child: Align(
            //     alignment: Alignment.bottomRight,
            //     child: SolidButton(
            //       onPressed: () {},
            //       text: 'Submit',
            //       width: 150,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
