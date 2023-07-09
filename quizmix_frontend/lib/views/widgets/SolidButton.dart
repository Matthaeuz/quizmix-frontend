import 'package:flutter/material.dart';

class ButtonSolid extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;

  const ButtonSolid({
    required this.text,
    required this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF03045E), // Button background color
        onPrimary: Colors.white, // Text color
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0), // Border radius
        ),
        minimumSize: width != null ? Size(width!, 50.0) : Size(50.0, 50.0), // Button size
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}
