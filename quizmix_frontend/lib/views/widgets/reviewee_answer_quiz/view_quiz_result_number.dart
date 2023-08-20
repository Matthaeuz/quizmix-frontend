import 'package:flutter/material.dart';

class ViewQuizResultNumber extends StatelessWidget {
  const ViewQuizResultNumber({
    super.key,
    required this.number,
    required this.isCorrect,
    required this.onClick,
  });

  final int number;
  final bool isCorrect;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        height: 40,
        width: 40,
        color: isCorrect ? Colors.green : Colors.red,
        margin: const EdgeInsets.all(4),
        child: Center(
          child: Text('$number'),
        ),
      ),
    );
  }
}
