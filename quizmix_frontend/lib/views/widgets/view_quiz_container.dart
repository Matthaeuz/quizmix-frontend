import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/base_url_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_questions/current_viewed_quiz_question_provider.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class ViewQuizContainer extends ConsumerWidget {
  final int index;

  const ViewQuizContainer({super.key, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseUrl = ref.watch(baseUrlProvider);
    final question = ref.watch(currentViewedQuizQuestionProvider);

    debugPrint('${question == Question.base()}');
    debugPrint('JSON: ${question!.toJson()}');
    debugPrint('QUESTION: ${Question.base}');

    return Expanded(
        flex: 5,
        child: question.question.isNotEmpty
            ? LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Container(
                    color: AppColors.fourthColor,
                    height: constraints.maxHeight,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.zero,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Question $index',
                                          style: const TextStyle(fontSize: 32),
                                        ),
                                        const SizedBox(width: 15),
                                        Align(
                                          // Wrap the Flexible with Align
                                          alignment: Alignment.centerLeft,
                                          child: Flexible(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 12,
                                                horizontal: 12,
                                              ),
                                              decoration: BoxDecoration(
                                                color: getCategoryColor(
                                                    question!.category),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Text(
                                                question.category,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                        SolidButton(
                                          text: 'Remove',
                                          onPressed: () {
                                            // Add your code for handling "Remove" press here
                                          },
                                          icon: const Icon(Icons.delete),
                                          backgroundColor: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Image.network(
                                    baseUrl + question.image!,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    'The correct answer is ${question.answer})',
                                    style: const TextStyle(fontSize: 28),
                                  ),
                                  const SizedBox(height: 20),
                                  const Text(
                                    'Explanation:',
                                    style: TextStyle(fontSize: 28),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    question.solution ?? 'No explanation',
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  );
                },
              )
            : const Placeholder());
  }
}
