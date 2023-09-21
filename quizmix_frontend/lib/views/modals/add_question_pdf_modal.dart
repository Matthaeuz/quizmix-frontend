import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/providers/file_picker/pdf_file_provider.dart';
import 'package:quizmix_frontend/state/providers/questions/question_bank_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewer/uploaded_questions_screen.dart';
import 'package:quizmix_frontend/views/widgets/pdf_input_button.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class AddQuestionPdfModal extends ConsumerStatefulWidget {
  const AddQuestionPdfModal({Key? key}) : super(key: key);

  @override
  AddQuestionPdfModalState createState() => AddQuestionPdfModalState();
}

class AddQuestionPdfModalState extends ConsumerState<AddQuestionPdfModal> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: IntrinsicHeight(
              child: Container(
                width: 480,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Add Questions Through PDFs",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Note: Please make sure the PhilNITS PDFs match and are in the right slots",
                        style: TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 24),
                      const Row(
                        children: [
                          PdfInputButton(
                            buttonText: 'Upload Question Set',
                            buttonIcon: Icons.upload_rounded,
                            buttonTextSize: 16,
                            buttonIconSize: 100,
                            type: 'q_file',
                          ),
                          SizedBox(width: 24),
                          PdfInputButton(
                            buttonText: 'Upload Answer Set',
                            buttonIcon: Icons.upload_rounded,
                            buttonTextSize: 16,
                            buttonIconSize: 100,
                            type: 'a_file',
                          )
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SolidButton(
                            text: 'Cancel',
                            width: 160,
                            onPressed: () {
                              ref
                                  .read(modalStateProvider.notifier)
                                  .updateModalState(ModalState.none);
                            },
                          ),
                          const SizedBox(width: 25),
                          SolidButton(
                            text: 'Continue',
                            width: 160,
                            onPressed: () {
                              final aFilePath =
                                  ref.read(pdfFileProvider('a_file')).state;
                              final qFilePath =
                                  ref.read(pdfFileProvider('q_file')).state;
                              if (aFilePath != null && qFilePath != null) {
                                // Upload questions to question bank
                                ref
                                    .read(questionBankProvider.notifier)
                                    .addQuestionsFromPdf(
                                        aFilePath, qFilePath, ref)
                                    .then(
                                  (value) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const UploadedQuestionsScreen()));
                                    ref
                                        .read(modalStateProvider.notifier)
                                        .updateModalState(ModalState.none);
                                  },
                                  onError: (error) {
                                    ref
                                        .read(modalStateProvider.notifier)
                                        .updateModalState(ModalState.none);
                                  },
                                );
                              } else {
                                debugPrint('something happened');
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
