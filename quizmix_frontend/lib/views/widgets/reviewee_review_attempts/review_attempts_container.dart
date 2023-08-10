import 'package:flutter/material.dart';

class ReviewAttemptsContainer extends StatelessWidget {
  const ReviewAttemptsContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Attempt 1'),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Text("80/80"),
            ),
          ),
          Expanded(
            child: Center(
              child: Text("July 7, 2023"),
            ),
          ),
          Expanded(
            child: Center(
              child: Text("7:00 AM"),
            ),
          ),
          Expanded(
            child: Center(
              child: Text("8:00 AM"),
            ),
          ),
        ],
      ),
    );
  }
}
