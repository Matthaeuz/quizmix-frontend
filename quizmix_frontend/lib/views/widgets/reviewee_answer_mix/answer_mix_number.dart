import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/mixes/answer_mix_responses_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_provider.dart';

class AnswerMixNumber extends ConsumerWidget {
  const AnswerMixNumber({
    super.key,
    required this.number,
    required this.currentNumber,
    required this.onClick,
  });

  final int number;
  final int currentNumber;
  final Function() onClick;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(currentMixProvider)!.questions;
    final responses = ref.watch(answerMixResponsesProvider);
    final thisResponse = responses[number - 1];
    final thisCorrectAnswer = questions[number - 1].answer;

    return InkWell(
      onTap: onClick,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: number == currentNumber
              ? AppColors.iconColor
              : thisResponse.isEmpty
                  ? AppColors.grey
                  : thisResponse == thisCorrectAnswer
                      ? Colors.green
                      : AppColors.red,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 4,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Center(
          child: Text(
            '$number',
            style: TextStyle(
              color: number == currentNumber ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }
}
