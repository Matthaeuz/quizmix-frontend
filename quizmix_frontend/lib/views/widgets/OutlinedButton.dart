import 'package:flutter/material.dart';

class ButtonOutlined extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ButtonOutlined({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white, // Button background color
        primary: Color(0xFF333333), // Text color
        side: BorderSide(
          color: Color(0xFF3A0CA3), // Border color
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Border radius
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        minimumSize: Size(50.0, 50.0),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}