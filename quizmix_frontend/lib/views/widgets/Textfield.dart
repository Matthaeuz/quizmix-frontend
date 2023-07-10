import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final bool obscureText;

  const TextFieldWidget({super.key, 
    required this.labelText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
      ),
      child: TextField(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        obscureText: obscureText,
      ),
    );
  }
}