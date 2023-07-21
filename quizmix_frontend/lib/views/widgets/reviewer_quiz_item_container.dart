import 'package:flutter/material.dart';

class ReviewerQuizItemContainer extends StatelessWidget {
  final String quizName;
  final String totalScore;
  final VoidCallback? onViewQuizPressed;
  final VoidCallback? onViewHistoryPressed;

  const ReviewerQuizItemContainer({
    super.key,
    required this.quizName,
    required this.totalScore,
    this.onViewQuizPressed,
    this.onViewHistoryPressed,
  });

  @override
  Widget build(BuildContext context) {
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
                Text(quizName),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text(totalScore),
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: onViewQuizPressed,
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Color(0xFF03045E),
                        width: 1.5,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'View Quiz',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: onViewHistoryPressed,
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Color(0xFF03045E),
                        width: 1,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'View History',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
