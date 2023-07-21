import 'package:flutter/material.dart';
import 'package:quizmix_frontend/views/widgets/pdf_input_button.dart';

class UploadButtonsSet extends StatelessWidget {
  const UploadButtonsSet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: PdfInputButton(
            buttonText: 'Upload Question Set',
            buttonIcon: Icons.upload,
            buttonTextSize: 16,
            buttonIconSize: 100,
            type: 'q_file',
          ),
        ),
        SizedBox(width: 25),
        Expanded(
            child: PdfInputButton(
          buttonText: 'Upload Answer Set',
          buttonIcon: Icons.upload,
          buttonTextSize: 16,
          buttonIconSize: 100,
          type: 'a_file',
        )),
      ],
    );
  }
}
