import 'package:flutter/material.dart';

class PdfInputButton extends StatelessWidget {
  final String buttonText;
  final IconData buttonIcon;
  final double buttonTextSize;
  final double buttonIconSize;

  const PdfInputButton({
    super.key,
    required this.buttonText,
    required this.buttonIcon,
    required this.buttonTextSize,
    required this.buttonIconSize,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle button press
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFF03045E),
        backgroundColor: const Color(0xFFCAF0F8),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Expanded(
        child: SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                buttonIcon,
                size: buttonIconSize,
                color: const Color(0xFF03045E),
              ),
              const SizedBox(height: 8),
              Text(
                buttonText,
                style: TextStyle(
                  fontSize: buttonTextSize,
                  color: const Color(0xFF03045E),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
