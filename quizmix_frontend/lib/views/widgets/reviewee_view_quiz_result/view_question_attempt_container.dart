import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/api/base_url_provider.dart';
import 'package:quizmix_frontend/state/providers/question_attempts/currently_viewed_question_attempt_provider.dart';

class ViewQuestionAttemptContainer extends ConsumerWidget {
  const ViewQuestionAttemptContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseUrl = ref.watch(baseUrlProvider);
    final questionDetails = ref.watch(currentViewedQuestionAttemptProvider);
    final questionNum = questionDetails["qnum"];
    final question = questionDetails["question"];

    return Expanded(
      flex: 5,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            color: AppColors.fourthColor,
            height: constraints.maxHeight,
            child: question.id != 0
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.zero,
                                child: Wrap(
                                  runSpacing: 20,
                                  children: [
                                    Text(
                                      'Question $questionNum',
                                      style: const TextStyle(fontSize: 32),
                                    ),
                                    const SizedBox(width: 12),
                                    Flexible(
                                      child: IntrinsicWidth(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                            horizontal: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: getCategoryColor(
                                                question.category),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
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
                                    ),
                                  ],
                                ),
                              ),
                              question.image != null
                                  ? const SizedBox(height: 20)
                                  : const SizedBox(),
                              question.image != null
                                  ? Image.network(
                                      question.image!.contains(baseUrl)
                                          ? question.image!
                                          : baseUrl + question.image!,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : const SizedBox(),
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
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          );
        },
      ),
    );
  }
}
