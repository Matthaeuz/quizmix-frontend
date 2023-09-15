import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/api/base_url_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/answer_mix_responses_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_provider.dart';

class AnswerMixItem extends ConsumerWidget {
  const AnswerMixItem({
    super.key,
    required this.currentQuestionIndex,
  });

  final int currentQuestionIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseUrl = ref.watch(baseUrlProvider);
    final questions = ref.watch(currentMixProvider)!.questions;
    final responses = ref.watch(answerMixResponsesProvider);
    final question = questions[currentQuestionIndex];
    final response = responses[currentQuestionIndex];
    final choiceLetters = ['A.', 'B.', 'C.', 'D.'];
    final isResponded = response.isNotEmpty;
    final isRespondedCorrectly = isResponded && response == question.answer;
    final textColor = isRespondedCorrectly ? Colors.green : Colors.red;
    final hasSolution =
        question.solution != null && question.solution!.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
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
                    Text('Back to Home'),
                  ],
                ),
              ),
              const Text(
                "Answer Mix",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Question No. ${currentQuestionIndex + 1}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                question.question,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 24),
              question.image != null
                  ? Image.network(
                      question.image!.contains(baseUrl)
                          ? question.image!
                          : baseUrl + question.image!,
                    )
                  : const SizedBox(),
              question.image != null
                  ? const SizedBox(height: 24)
                  : const SizedBox(),
              const Text(
                'Choices',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: question.choices.length,
                itemBuilder: (context, index) {
                  return Text(
                    '${choiceLetters[index]} ${question.choices[index]}',
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  );
                },
              ),
              Container(
                padding: isResponded
                    ? const EdgeInsets.fromLTRB(0, 24, 0, 24)
                    : null,
                child: isResponded
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Answer',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'The correct answer is ${question.answer.toUpperCase()}.',
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Text(
                            'Your answer: ${response.toUpperCase()}.',
                            style: TextStyle(
                              color: textColor,
                              fontSize: 20,
                            ),
                          ),
                          hasSolution
                              ? Text(
                                  'Reviewer\'s Explanation: ${question.solution}',
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 20,
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
