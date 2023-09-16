import 'package:flutter/material.dart';
import 'package:quizmix_frontend/api/helpers/datetime_convert.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/quiz_attempts/quiz_attempt.dart';

class ReviewAttemptsContainer extends StatelessWidget {
  final QuizAttempt attempt;
  final int index;

  const ReviewAttemptsContainer(
      {super.key, required this.attempt, required this.index});

  @override
  Widget build(BuildContext context) {
    final totalScore = attempt.quiz.questions.length;

    return Container(
      height: 60,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 6,
            child: Text(
              "${dateTimeToWordDate(attempt.createdOn)}, ${dateTimeToTime(attempt.timeStarted)}-${attempt.timeFinished != null ? dateTimeToTime(attempt.timeFinished!) : "N/A"}",
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Text(
              "Score: ${attempt.attemptScore}/$totalScore",
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
