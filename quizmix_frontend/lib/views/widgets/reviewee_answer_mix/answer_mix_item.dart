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

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.mainColor,
            width: 1,
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      isResponded ? const EdgeInsets.only(bottom: 25) : null,
                  child: isResponded
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'The correct answer is ${question.answer.toUpperCase()}.',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              'Your answer: ${response.toUpperCase()}.',
                              style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                              ),
                            ),
                            hasSolution
                                ? Text(
                                    'Reviewer\'s Explanation: ${question.solution}',
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 16,
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        )
                      : null,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                question.image != null
                    ? Image.network(
                        question.image!.contains(baseUrl)
                            ? question.image!
                            : baseUrl + question.image!,
                      )
                    : const SizedBox(),
                question.image != null
                    ? const SizedBox(
                        height: 25,
                      )
                    : const SizedBox(),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Choices',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: question.choices.length,
                  itemBuilder: (context, index) {
                    return Text(
                      '${choiceLetters[index]} ${question.choices[index]}',
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
