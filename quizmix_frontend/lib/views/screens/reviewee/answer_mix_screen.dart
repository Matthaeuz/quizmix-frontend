import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/mixes/answer_mix_responses_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_provider.dart';
import 'package:quizmix_frontend/views/widgets/responsive_tiny_solid_button.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_answer_mix/answer_mix_item.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_answer_mix/answer_mix_number.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class AnswerMixScreen extends ConsumerStatefulWidget {
  const AnswerMixScreen({Key? key}) : super(key: key);

  @override
  AnswerMixScreenState createState() => AnswerMixScreenState();
}

class AnswerMixScreenState extends ConsumerState<AnswerMixScreen> {
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
    double screenWidth = MediaQuery.of(context).size.width;
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
                      child: AnswerMixItem(
                        currentQuestionIndex: currentQuestionIndex,
                      ),
                    ),
                  ),
                  responses[currentQuestionIndex].isEmpty && screenHeight > 200
                      ? Padding(
                          padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                          child: Row(
                            children: [
                              Expanded(
                                child: SolidButton(
                                  text: 'A',
                                  elevation: 8.0,
                                  onPressed: () {
                                    handleChoicePressed('a', questions);
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SolidButton(
                                  text: 'B',
                                  elevation: 8.0,
                                  onPressed: () {
                                    handleChoicePressed('b', questions);
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SolidButton(
                                  text: 'C',
                                  elevation: 8.0,
                                  onPressed: () {
                                    handleChoicePressed('c', questions);
                                  },
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SolidButton(
                                  text: 'D',
                                  elevation: 8.0,
                                  onPressed: () {
                                    handleChoicePressed('d', questions);
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
                      SizedBox(height: screenHeight > 160 ? 12 : 0),
                      Row(
                        children: [
                          Expanded(
                            child: currentQuestionIndex > 0 &&
                                    screenHeight > 160 &&
                                    screenWidth > 896
                                ? ResponsiveTinySolidButton(
                                    text: 'Previous',
                                    icon: Icons.arrow_back,
                                    buttonColor: AppColors.iconColor,
                                    condition: screenWidth > 1080,
                                    elevation: 8.0,
                                    onPressed: () {
                                      setState(() {
                                        currentQuestionIndex--;
                                      });
                                    },
                                  )
                                : const SizedBox(),
                          ),
                          const SizedBox(width: 4),
                          screenHeight > 160 && screenWidth > 896
                              ? Expanded(
                                  child: currentQuestionIndex <
                                          currentMix.questions.length - 1
                                      ? ResponsiveTinySolidButton(
                                          text: 'Next',
                                          icon: Icons.arrow_forward,
                                          buttonColor: AppColors.iconColor,
                                          condition: screenWidth > 1080,
                                          elevation: 8.0,
                                          onPressed: () {
                                            setState(() {
                                              currentQuestionIndex++;
                                            });
                                          },
                                        )
                                      : ResponsiveTinySolidButton(
                                          text: 'Finish',
                                          icon: Icons.check_circle_outlined,
                                          buttonColor: AppColors.iconColor,
                                          condition: screenWidth > 1080,
                                          elevation: 8.0,
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                )
                              : const SizedBox(),
                        ],
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
  }
}
