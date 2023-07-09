import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelText;
  final bool obscureText;

  const TextFieldWidget({
    required this.labelText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
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