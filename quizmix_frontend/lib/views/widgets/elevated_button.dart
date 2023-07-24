import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';

class ButtonElevated extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ButtonElevated({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.mainColor, // Button background color
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Border radius
        ),
        minimumSize: const Size(50.0, 50.0), // Button size
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }
}
