import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/api/base_url_provider.dart';
import 'package:quizmix_frontend/state/providers/question_attempts/currently_viewed_question_attempt_provider.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';

class ViewQuestionAttemptContainer extends ConsumerWidget {
  const ViewQuestionAttemptContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseUrl = ref.watch(baseUrlProvider);
    final questionDetails = ref.watch(currentViewedQuestionAttemptProvider);
    final questionNum = questionDetails["qanum"];
    final questionAttempt = questionDetails["questionAttempt"];
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
                      'Category: ${questionAttempt.question.category.name}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      questionAttempt.question.question,
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    questionAttempt.question.image != null
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: Image.network(
                              baseUrl + questionAttempt.question.image!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const SizedBox(),
                    for (var i = 0;
                        i < questionAttempt.question.choices.length;
                        i++) ...[
                      Text(
                        '${choiceLetters[i]}. ${questionAttempt.question.choices[i]}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                    const SizedBox(height: 16),
                    Text(
                      'Answer: ${questionAttempt.question.answer.toUpperCase()}. ${questionAttempt.question.choices[choiceLetters.indexOf(questionAttempt.question.answer.toUpperCase())]}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Reviewee\'s Answer: ${questionAttempt.revieweeAnswer.toUpperCase()}. ${questionAttempt.question.choices[choiceLetters.indexOf(questionAttempt.revieweeAnswer.toUpperCase())]}',
                      style: TextStyle(
                        fontSize: 16,
                        color: questionAttempt.isCorrect
                            ? AppColors.green
                            : AppColors.red,
                      ),
                    ),
                    questionAttempt.question.solution != null &&
                            questionAttempt.question.solution!.isNotEmpty
                        ? Text(
                            'Reviewer\'s Explanation: ${questionAttempt.question.solution}',
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
