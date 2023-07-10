import 'package:flutter/material.dart';

class ButtonOutlined extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ButtonOutlined({super.key, 
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFF333333), backgroundColor: Colors.white,
        side: const BorderSide(
          color: Color(0xFF3A0CA3), // Border color
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Border radius
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