import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';

class AnswerQuizNumber extends StatelessWidget {
  const AnswerQuizNumber({
    super.key,
    required this.number,
    required this.currentNumber,
    required this.allQuestionsAnswered,
  });

  final int number;
  final int currentNumber;
  final bool allQuestionsAnswered;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      color: allQuestionsAnswered
          ? const Color.fromARGB(115, 158, 158, 158)
          : currentNumber == number
              ? AppColors.mainColor
              : currentNumber > number
                  ? const Color.fromARGB(115, 158, 158, 158)
                  : AppColors.thirdColor,
      margin: const EdgeInsets.all(4),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            color: number == currentNumber && !allQuestionsAnswered
                ? Colors.white
                : null,
          ),
        ),
      ),
    );
  }
}
