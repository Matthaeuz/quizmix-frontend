import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';

class SolidButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final Widget? icon;
  final Color? backgroundColor;
  final bool? isUnpressable;

  const SolidButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.icon,
    this.backgroundColor,
    this.isUnpressable,
  });

  @override
  Widget build(BuildContext context) {
    Color? buttonColor = backgroundColor;
    if (isUnpressable == true) {
      buttonColor = AppColors.grey;
    } else {
      buttonColor = AppColors.mainColor;
    }

    return ElevatedButton(
      onPressed: isUnpressable == true ? null : onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: buttonColor,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        minimumSize:
            width != null ? Size(width!, 50.0) : const Size(50.0, 50.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: icon!,
            ),
          Text(
            text,
            style: const TextStyle(fontSize: 16.0),
          ),
        ],
      ),
    );
  }
}
