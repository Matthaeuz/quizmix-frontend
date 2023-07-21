import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/providers/file_picker/pdf_file_provider.dart';

class PdfInputButton extends ConsumerStatefulWidget {
  final String buttonText;
  final IconData buttonIcon;
  final double buttonTextSize;
  final double buttonIconSize;
  final String type;

  const PdfInputButton({
    super.key,
    required this.buttonText,
    required this.buttonIcon,
    required this.buttonTextSize,
    required this.buttonIconSize,
    required this.type,
  });

  @override
  ConsumerState<PdfInputButton> createState() => _PdfInputButtonState();
}

class _PdfInputButtonState extends ConsumerState<PdfInputButton> {
  bool isPdfUploaded = false;
  String pdfFileName = '';

  void _pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      ref.read(pdfFileProvider(widget.type)).state = result.files.single;
      setState(() {
        isPdfUploaded = true;
        pdfFileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _pickPdfFile();
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
                isPdfUploaded ? Icons.picture_as_pdf : widget.buttonIcon,
                size: widget.buttonIconSize,
                color: const Color(0xFF03045E),
              ),
              const SizedBox(height: 8),
              Text(
                isPdfUploaded ? pdfFileName : widget.buttonText,
                style: TextStyle(
                  fontSize: widget.buttonTextSize,
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
