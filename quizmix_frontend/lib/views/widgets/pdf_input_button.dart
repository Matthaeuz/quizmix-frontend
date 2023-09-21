import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
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
    return Stack(
      children: [
        ElevatedButton(
          onPressed: () {
            _pickPdfFile();
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.white,
            backgroundColor: AppColors.iconColor,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: Container(
            height: 200,
            constraints: const BoxConstraints(minWidth: 190, maxWidth: 190),
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isPdfUploaded ? Icons.picture_as_pdf : widget.buttonIcon,
                  size: widget.buttonIconSize,
                  color: AppColors.white,
                ),
                const SizedBox(height: 8),
                Text(
                  isPdfUploaded ? pdfFileName : widget.buttonText,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: widget.buttonTextSize,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        isPdfUploaded
            ? Positioned(
                top: 0,
                right: 0,
                child: RawMaterialButton(
                  onPressed: () {
                    ref.read(pdfFileProvider(widget.type)).state = null;
                    setState(() {
                      isPdfUploaded = false;
                      pdfFileName = '';
                    });
                  },
                  fillColor: AppColors.red,
                  shape: const CircleBorder(),
                  constraints: const BoxConstraints(
                    minWidth: 36.0,
                    minHeight: 36.0,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                ))
            : const SizedBox(),
      ],
    );
  }
}
