import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';

class ButtonOutlined extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ButtonOutlined({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.black,
        backgroundColor: AppColors.white,
        side: const BorderSide(
          color: AppColors.iconColor,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        minimumSize: const Size(50.0, 50.0),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }
}
