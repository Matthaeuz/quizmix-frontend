import 'package:flutter/material.dart';
import 'package:quizmix_frontend/api/helpers/datetime_convert.dart';
import 'package:quizmix_frontend/state/models/quiz_attempts/quiz_attempt.dart';

class QuizHistoryItem extends StatelessWidget {
  final QuizAttempt attempt;

  const QuizHistoryItem({super.key, required this.attempt});

  @override
  Widget build(BuildContext context) {
    final totalScore = attempt.quiz.questions.length;

    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(attempt.attemptedBy.fullName),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text("${attempt.attemptScore}/$totalScore"),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(dateTimeToDate(attempt.createdOn)),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(dateTimeToTime(attempt.timeStarted)),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(attempt.timeFinished != null
                  ? dateTimeToTime(attempt.timeFinished!)
                  : "Did not finish attempt"),
            ),
          ),
        ],
      ),
    );
  }
}
