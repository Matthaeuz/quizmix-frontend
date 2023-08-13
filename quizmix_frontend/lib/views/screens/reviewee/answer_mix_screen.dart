import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/mixes/answer_mix_responses_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_answer_mix/answer_mix_item.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_answer_mix/answer_mix_number.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';
import 'package:quizmix_frontend/views/widgets/tiny_solid_button.dart';

class AnswerMixScreen extends ConsumerStatefulWidget {
  AnswerMixScreen({Key? key}) : super(key: key);

  @override
  _AnswerMixScreenState createState() => _AnswerMixScreenState();
}

class _AnswerMixScreenState extends ConsumerState<AnswerMixScreen> {
  int currentQuestionIndex = 0;

  void handleChoicePressed(String choice, List<Question> questions) {
    ref
        .read(answerMixResponsesProvider.notifier)
        .updateResponses(currentQuestionIndex, choice);
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentMix = ref.watch(currentMixProvider);
    final responses = ref.watch(answerMixResponsesProvider);
    final questions = currentMix!.questions;

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
          'Answer Mix',
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
                        AnswerMixItem(
                            currentQuestionIndex: currentQuestionIndex),
                        responses[currentQuestionIndex].isEmpty
                            ? const SizedBox(height: 25)
                            : const SizedBox(),
                        responses[currentQuestionIndex].isEmpty
                            ? Row(
                                children: [
                                  Expanded(
                                    child: SolidButton(
                                      onPressed: () {
                                        handleChoicePressed('a', questions);
                                      },
                                      text: 'Choice A',
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: SolidButton(
                                      onPressed: () {
                                        handleChoicePressed('b', questions);
                                      },
                                      text: 'Choice B',
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: SolidButton(
                                      onPressed: () {
                                        handleChoicePressed('c', questions);
                                      },
                                      text: 'Choice C',
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: SolidButton(
                                      onPressed: () {
                                        handleChoicePressed('d', questions);
                                      },
                                      text: 'Choice D',
                                    ),
                                  )
                                ],
                              )
                            : const SizedBox(),
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
                      padding: const EdgeInsets.fromLTRB(8, 12, 8, 12),
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                child: Wrap(
                                  children: [
                                    for (int i = 0;
                                        i < currentMix.questions.length;
                                        i++) ...[
                                      AnswerMixNumber(
                                        number: i + 1,
                                        currentNumber: currentQuestionIndex + 1,
                                        onClick: () {
                                          setState(() {
                                            currentQuestionIndex = i;
                                          });
                                        },
                                      )
                                    ]
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const SizedBox(width: 4),
                                Expanded(
                                  child: currentQuestionIndex > 0
                                      ? TinySolidButton(
                                          text: 'Previous',
                                          icon: Icons.arrow_back,
                                          buttonColor: AppColors.mainColor,
                                          onPressed: () {
                                            setState(() {
                                              currentQuestionIndex--;
                                            });
                                          },
                                        )
                                      : const SizedBox(),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: currentQuestionIndex <
                                          currentMix.questions.length - 1
                                      ? TinySolidButton(
                                          text: 'Next',
                                          icon: Icons.arrow_forward,
                                          buttonColor: AppColors.mainColor,
                                          onPressed: () {
                                            setState(() {
                                              currentQuestionIndex++;
                                            });
                                          },
                                        )
                                      : TinySolidButton(
                                          text: 'Finish',
                                          icon: Icons.check_circle_outlined,
                                          buttonColor: AppColors.mainColor,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                ),
                                const SizedBox(width: 4),
                              ],
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
