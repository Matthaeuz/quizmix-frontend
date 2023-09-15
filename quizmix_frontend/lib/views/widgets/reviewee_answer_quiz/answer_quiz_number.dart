import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';

class AnswerQuizNumber extends StatelessWidget {
  const AnswerQuizNumber({
    super.key,
    required this.number,
    required this.currentNumber,
  });

  final int number;
  final int currentNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: currentNumber == number
            ? AppColors.iconColor
            : currentNumber > number
                ? AppColors.grey
                : AppColors.thirdColor,
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
    );
  }
}
