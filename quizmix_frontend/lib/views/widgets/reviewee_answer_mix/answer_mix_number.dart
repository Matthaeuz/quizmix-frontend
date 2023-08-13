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
        color: number == currentNumber
            ? AppColors.mainColor
            : thisResponse.isEmpty
                ? const Color.fromARGB(115, 158, 158, 158)
                : thisResponse == thisCorrectAnswer
                    ? Colors.green
                    : Colors.red,
        margin: const EdgeInsets.all(4),
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
