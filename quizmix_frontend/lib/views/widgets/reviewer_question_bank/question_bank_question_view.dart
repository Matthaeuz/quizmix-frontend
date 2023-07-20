import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/questions/current_question_provider.dart';

class QuestionBankQuestion extends ConsumerWidget {
  const QuestionBankQuestion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentQuestion = ref.watch(currentQuestionProvider);

    return Expanded(
      flex: 5,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // final selectedQuestion = selectedQuestionIndex != null
          //     ? questionDetails[selectedQuestionIndex!]
          //     : null;

          return Container(
            color: const Color(0xFF90E0EF),
            height: constraints.maxHeight,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: currentQuestion != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Question ${currentQuestion.id + 1}',
                                    style: const TextStyle(fontSize: 32),
                                  ),
                                  const SizedBox(width: 15),
                                  Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: getCategoryColor(
                                            currentQuestion.category),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        currentQuestion.category,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Image.network(
                                currentQuestion.image!,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'The correct answer is "${currentQuestion.answer}"',
                                style: const TextStyle(fontSize: 28),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Explanation:',
                                style: TextStyle(fontSize: 28),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                currentQuestion.solution == ''
                                    ? 'No explanation available'
                                    : currentQuestion.solution!,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ],
                          )
                        : Container(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
