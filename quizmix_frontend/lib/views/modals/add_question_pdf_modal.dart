import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/file_picker/pdf_file_provider.dart';
import 'package:quizmix_frontend/state/providers/questions/question_bank_provider.dart';
import 'package:quizmix_frontend/state/providers/questions/uploaded_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/process_state_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewer/uploaded_questions_screen.dart';
import 'package:quizmix_frontend/views/widgets/pdf_input_button.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class AddQuestionPdfModal extends ConsumerStatefulWidget {
  const AddQuestionPdfModal({Key? key}) : super(key: key);

  @override
  AddQuestionPdfModalState createState() => AddQuestionPdfModalState();
}

class AddQuestionPdfModalState extends ConsumerState<AddQuestionPdfModal> {
  @override
  Widget build(BuildContext context) {
    final processState = ref.watch(processStateProvider);

    return Scaffold(
      appBar: null,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            width: 452,
            padding: const EdgeInsets.fromLTRB(24, 0, 4, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: processState == ProcessState.loading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(24, 48, 24, 48),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: 48.0,
                              width: 48.0,
                              child:
                                  CircularProgressIndicator(strokeWidth: 6.0),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              "Extracting Questions...",
                              style: TextStyle(
                                fontSize: 24.0,
                                color: AppColors.mainColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(modalStateProvider.notifier)
                                  .updateModalState(ModalState.none);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.centerLeft,
                              foregroundColor: AppColors.mainColor,
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  size: 16.0,
                                  color: AppColors.mainColor,
                                ),
                                Text('Back to Question Bank'),
                              ],
                            ),
                          ),
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
                                buttonText: 'Questions PDF',
                                buttonIcon: Icons.upload_rounded,
                                buttonTextSize: 16,
                                buttonIconSize: 100,
                                type: 'q_file',
                              ),
                              SizedBox(width: 24),
                              PdfInputButton(
                                buttonText: 'Answers PDF',
                                buttonIcon: Icons.upload_rounded,
                                buttonTextSize: 16,
                                buttonIconSize: 100,
                                type: 'a_file',
                              )
                            ],
                          ),
                          const SizedBox(height: 24),
                          Align(
                            alignment: Alignment.centerRight,
                            child: SolidButton(
                              text: 'Upload Questions',
                              width: 160,
                              icon: const Icon(Icons.play_circle_outline),
                              onPressed: () async {
                                final aFilePath =
                                    ref.read(pdfFileProvider('a_file')).state;
                                final qFilePath =
                                    ref.read(pdfFileProvider('q_file')).state;
                                if (aFilePath != null && qFilePath != null) {
                                  ref
                                      .read(processStateProvider.notifier)
                                      .updateProcessState(ProcessState.loading);
                                  // Upload questions to question bank
                                  ref
                                      .read(questionBankProvider.notifier)
                                      .addQuestionsFromPdf(
                                          aFilePath, qFilePath, ref)
                                      .then(
                                    (value) {
                                      ref
                                          .read(uploadedQuestionsProvider
                                              .notifier)
                                          .updateUploadedQuestions(value);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const UploadedQuestionsScreen()));
                                      ref
                                          .read(processStateProvider.notifier)
                                          .updateProcessState(
                                              ProcessState.done);
                                    },
                                    onError: (error) {
                                      ref
                                          .read(processStateProvider.notifier)
                                          .updateProcessState(
                                              ProcessState.done);
                                      ref
                                          .read(modalStateProvider.notifier)
                                          .updateModalState(ModalState.none);
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
