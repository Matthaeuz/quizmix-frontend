import 'package:flutter/material.dart';

class ButtonSolid extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;

  const ButtonSolid({super.key, 
    required this.text,
    required this.onPressed,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: const Color(0xFF03045E),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        minimumSize: width != null ? Size(width!, 50.0) : const Size(50.0, 50.0),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }
}
