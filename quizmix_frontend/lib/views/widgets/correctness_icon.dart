import 'package:flutter/material.dart';

class CorrectnessIcon extends StatelessWidget {
  const CorrectnessIcon({
    super.key,
    required this.isCorrect,
    this.padding,
    this.iconSize,
  });

  final bool isCorrect;
  final EdgeInsetsGeometry? padding;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: isCorrect ? Colors.green : Colors.red,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          isCorrect ? Icons.check : Icons.close,
          color: Colors.white,
          size: iconSize,
        ),
      ),
    );
  }
}
