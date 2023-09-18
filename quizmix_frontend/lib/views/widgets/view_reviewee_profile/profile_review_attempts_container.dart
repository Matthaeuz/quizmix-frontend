import 'package:flutter/material.dart';
import 'package:quizmix_frontend/api/helpers/datetime_convert.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/quiz_attempts/quiz_attempt.dart';

class ProfileReviewAttemptsContainer extends StatelessWidget {
  final QuizAttempt attempt;
  final int index;
  final Color color;

  const ProfileReviewAttemptsContainer({
    super.key,
    required this.attempt,
    required this.index,
    this.color = AppColors.mainColor,
  });

  @override
  Widget build(BuildContext context) {
    final totalScore = attempt.quiz.questions.length;

    return Container(
      height: 60,
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dateTimeToWordDate(attempt.createdOn),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  "${dateTimeToTime(attempt.timeStarted)}-${attempt.timeFinished != null ? dateTimeToTime(attempt.timeFinished!) : "N/A"}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  attempt.quiz.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  'Attempt No. ${index + 1}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${attempt.attemptScore}/$totalScore",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.white,
                  ),
                ),
                const Text(
                  "Score",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
