import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';

class EmptyDataPlaceholder extends StatelessWidget {
  final String message;
  final double iconSize;
  final double fontSize;

  const EmptyDataPlaceholder(
      {Key? key, required this.message, this.iconSize = 60, this.fontSize = 16})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double padding = iconSize * 0.1;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: iconSize,
            color: AppColors.white,
          ),
          SizedBox(height: padding),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
        ],
      ),
    );
  }
}
