import 'package:flutter/material.dart';

class ResponsiveTinySolidButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color buttonColor;
  final VoidCallback onPressed;
  final bool condition;
  final double? elevation;

  const ResponsiveTinySolidButton({
    super.key,
    required this.text,
    required this.icon,
    required this.buttonColor,
    required this.onPressed,
    required this.condition,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: elevation,
        foregroundColor: Colors.white,
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(right: condition ? 8.0 : 0.0),
            child: Icon(icon),
          ),
          condition
              ? Flexible(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
