import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/questions/current_question_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';
import 'package:quizmix_frontend/views/modals/quiz_advanced_search_modal.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class ViewQuestionModal extends ConsumerStatefulWidget {
  const ViewQuestionModal({Key? key}) : super(key: key);

  @override
  ConsumerState<ViewQuestionModal> createState() => _ViewQuestionModalState();
}

class _ViewQuestionModalState extends ConsumerState<ViewQuestionModal> {
  String getInterpretationFromDiff(double difficulty) {
    if (difficulty < -30) {
      return allDifficulty[0];
    } else if (difficulty >= -30 && difficulty < -10) {
      return allDifficulty[1];
    } else if (difficulty >= -10 && difficulty < 10) {
      return allDifficulty[2];
    } else if (difficulty >= 10 && difficulty < 30) {
      return allDifficulty[3];
    } else {
      return allDifficulty[4];
    }
  }

  String getInterpretationFromDisc(double discrimination) {
    if (discrimination < -30) {
      return allDiscrimination[0];
    } else if (discrimination >= -30 && discrimination < -10) {
      return allDiscrimination[1];
    } else if (discrimination >= -10 && discrimination < 10) {
      return allDiscrimination[2];
    } else if (discrimination >= 10 && discrimination < 30) {
      return allDiscrimination[3];
    } else {
      return allDiscrimination[4];
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final currentQuestion = ref.watch(currentQuestionProvider);
    final choiceLetters = ['A', 'B', 'C', 'D'];

    return Scaffold(
      appBar: null,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: IntrinsicHeight(
            child: Container(
              width: 800,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        ref
                            .read(modalStateProvider.notifier)
                            .updateModalState(ModalState.none);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                        foregroundColor: AppColors.mainColor,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            size: 16.0,
                            color: AppColors.mainColor,
                          ),
                          Text('Back to Question Bank'),
                        ],
                      ),
                    ),
                    currentQuestion != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Question ${currentQuestion.id}',
                                        style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Category: ${currentQuestion.category.name}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  if (user.role == "reviewer") ...[
                                    SolidButton(
                                      text: "Edit",
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        ref
                                            .read(modalStateProvider.notifier)
                                            .updateModalState(
                                                ModalState.createEditQuestion);
                                      },
                                    ),
                                  ]
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                currentQuestion.question,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 16),
                              currentQuestion.image != null
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: Image.network(
                                        currentQuestion.image!,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const SizedBox(),
                              for (var i = 0;
                                  i < currentQuestion.choices.length;
                                  i++) ...[
                                Text(
                                  '${choiceLetters[i]}. ${currentQuestion.choices[i]}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                              const SizedBox(height: 16),
                              Text(
                                'Answer: ${currentQuestion.answer.toUpperCase()}. ${currentQuestion.choices[choiceLetters.indexOf(currentQuestion.answer.toUpperCase())]}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              currentQuestion.solution != null &&
                                      currentQuestion.solution!.isNotEmpty
                                  ? Text(
                                      'Reviewer\'s Explanation: ${currentQuestion.solution}',
                                      style: const TextStyle(fontSize: 16),
                                    )
                                  : const SizedBox(),
                              const SizedBox(height: 16),
                              if (user.role == "reviewer") ...[
                                const Text(
                                  'Question Parameters:',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Discrimination: ${currentQuestion.parameters[0].toStringAsFixed(4)} - ${getInterpretationFromDisc(currentQuestion.parameters[0])}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  'Difficulty: ${currentQuestion.parameters[1].toStringAsFixed(4)} - ${getInterpretationFromDiff(currentQuestion.parameters[1])}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  //((1 / (1 + exp(-currentQuestion.parameters[0] * (0 - currentQuestion.parameters[1])))) * 100).toStringAsFixed(2)
                                  'Probability of 0-theta reviewee to get correct answer: ${((1 / (1 + exp(-currentQuestion.parameters[0] * (0 - currentQuestion.parameters[1])))) * 100).toStringAsFixed(2)}%',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ]
                            ],
                          )
                        : const Expanded(
                            child: Center(
                              child: EmptyDataPlaceholder(
                                message: "Please try again later",
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
