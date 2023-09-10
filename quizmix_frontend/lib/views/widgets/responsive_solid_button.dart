import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';

class ResponsiveSolidButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final Widget? icon;
  final Color? backgroundColor;
  final bool? isUnpressable;
  final bool condition;
  final double? elevation;

  const ResponsiveSolidButton({
    super.key,
    required this.text,
    required this.condition,
    required this.onPressed,
    this.width,
    this.icon,
    this.backgroundColor,
    this.isUnpressable,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    Color? buttonColor;
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        minimumSize:
            width != null ? Size(width!, 48.0) : const Size(48.0, 48.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Padding(
              padding: EdgeInsets.only(right: condition ? 8.0 : 0.0),
              child: icon!,
            ),
          condition
              ? Flexible(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
