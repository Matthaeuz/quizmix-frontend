import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';

class GridSolidButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final Widget? icon;
  final Color? backgroundColor;
  final bool? isUnpressable;
  final double? elevation;

  const GridSolidButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.icon,
    this.backgroundColor,
    this.isUnpressable,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    Color? buttonColor = backgroundColor;
    if (isUnpressable == true) {
      buttonColor = AppColors.grey;
    } else if (backgroundColor == null) {
      buttonColor = AppColors.iconColor;
    } else {
      buttonColor = backgroundColor;
    }

    return ElevatedButton(
      onPressed: isUnpressable == true ? null : onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        foregroundColor: Colors.white,
        backgroundColor: buttonColor,
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0), // Smaller padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Smaller border radius
        ),
        minimumSize: const Size(40.0, 40.0), // Smaller size
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 4.0), // Less padding next to the icon
              child: icon, // Smaller icon size
            ),
          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 14.0), // Smaller font size
            ),
          ),
        ],
      ),
    );
  }
}
