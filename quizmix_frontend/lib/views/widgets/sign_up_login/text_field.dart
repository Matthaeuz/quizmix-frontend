import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final bool obscureText;

  const TextFieldWidget({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.obscureText,
  }) : super(key: key);

  @override
  TextFieldWidgetState createState() => TextFieldWidgetState();
}

class TextFieldWidgetState extends State<TextFieldWidget> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText == false ? false : obscureText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
