import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/file_picker/dataset_file_provider.dart';

class DatasetInputButton extends ConsumerStatefulWidget {

  const DatasetInputButton({
    super.key,
  });

  @override
  ConsumerState<DatasetInputButton> createState() => _DatasetInputButtonState();
}

class _DatasetInputButtonState extends ConsumerState<DatasetInputButton> {
  bool isFileUploaded = false;
  String fileName = '';

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'csv'],
    );

    if (result != null) {
      ref.read(datasetFileProvider).state = result.files.single;
      setState(() {
        isFileUploaded = true;
        fileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ElevatedButton(
          onPressed: () {
            pickFile();
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
                  isFileUploaded ? Icons.picture_as_pdf : Icons.upload_rounded,
                  size: 100,
                  color: AppColors.white,
                ),
                const SizedBox(height: 8),
                Text(
                  isFileUploaded ? fileName : "Upload Dataset",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        isFileUploaded
            ? Positioned(
                top: 0,
                right: 0,
                child: RawMaterialButton(
                  onPressed: () {
                    ref.read(datasetFileProvider).state = null;
                    setState(() {
                      isFileUploaded = false;
                      fileName = '';
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
