import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/utils/upload_pdf.helper.dart';
import 'package:quizmix_frontend/state/providers/file_picker/pdf_file_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewer/update_quiz_bank_screen.dart';
import 'package:quizmix_frontend/views/screens/reviewer/uploaded_questions_screen.dart';
import 'package:quizmix_frontend/views/widgets/pdf_input_button.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class AddQuestionScreen extends ConsumerWidget {
  const AddQuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          UpdateQuizBankScreen(),
          Container(
            color: const Color(0x800077B6),
          ),
          Scaffold(
            appBar: null,
            backgroundColor: Colors.transparent,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: IntrinsicHeight(
                  child: Container(
                    width: 600,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Row(
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
                          ),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ButtonSolid(
                                text: 'Cancel',
                                width: 200,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              const SizedBox(width: 25),
                              ButtonSolid(
                                text: 'Continue',
                                width: 200,
                                onPressed: () {
                                  final aFilePath =
                                      ref.read(pdfFileProvider('a_file')).state;
                                  final qFilePath =
                                      ref.read(pdfFileProvider('q_file')).state;
                                  if (aFilePath != null && qFilePath != null) {
                                    debugPrint('what it worked');
                                    createQuestionsFromPdf(aFilePath, qFilePath, ref)
                                        .then((value) => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UploadedQuestionsScreen())));
                                  } else {
                                    debugPrint('what');
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
        ],
      ),
    );
  }
}
