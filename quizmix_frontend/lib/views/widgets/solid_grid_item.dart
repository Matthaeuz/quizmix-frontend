import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';

class SolidGridItem extends StatelessWidget {
  final Function() onPressed;
  final String label;

  const SolidGridItem(
      {super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: AppColors.iconColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 4,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.white
            ),
          ),
        ),
      ),
    );
  }
}
