import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/api/base_url_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_questions/current_viewed_quiz_question_provider.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';

class ViewQuizQuestionContainer extends ConsumerWidget {
  const ViewQuizQuestionContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseUrl = ref.watch(baseUrlProvider);
    final questionDetails = ref.watch(currentViewedQuizQuestionProvider);
    final questionNum = questionDetails["qnum"];
    final question = questionDetails["question"];
    final choiceLetters = ['A', 'B', 'C', 'D'];

    return Expanded(
      child: questionNum != 0
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question $questionNum',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Category: ${question.category.name}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      question.question,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    question.image != null
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Image.network(
                              baseUrl + question.image!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const SizedBox(),
                    for (var i = 0; i < question.choices.length; i++) ...[
                      Text(
                        '${choiceLetters[i]}. ${question.choices[i]}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                    const SizedBox(height: 16),
                    Text(
                      'Answer: ${question.answer.toUpperCase()}. ${question.choices[choiceLetters.indexOf(question.answer.toUpperCase())]}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    question.solution != null && question.solution!.isNotEmpty
                        ? Text(
                            'Reviewer\'s Explanation: ${question.solution}',
                            style: const TextStyle(fontSize: 16),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            )
          : const Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: EmptyDataPlaceholder(
                    message: "Click on a question to view its details",
                    color: AppColors.mainColor,
                  ),
                ),
              ),
            ),
    );
  }
}
