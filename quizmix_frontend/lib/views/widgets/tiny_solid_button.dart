import 'package:flutter/material.dart';

class TinySolidButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color buttonColor;
  final VoidCallback onPressed;

  const TinySolidButton({
    super.key,
    required this.text,
    required this.icon,
    required this.buttonColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: Icon(icon),
      label: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Poppins',
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
