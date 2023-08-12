import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';

class EmptyDataPlaceholder extends StatelessWidget {
  final String message;
  final double iconSize;
  final double fontSize;

  const EmptyDataPlaceholder(
      {Key? key,
      required this.message,
      this.iconSize = 200,
      this.fontSize = 24})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double padding = iconSize * 0.1;

    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Center(
          child: Scrollbar(
        thumbVisibility: false,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.info_outline_rounded,
                  size: iconSize, color: AppColors.mainColor),
              SizedBox(height: padding),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
