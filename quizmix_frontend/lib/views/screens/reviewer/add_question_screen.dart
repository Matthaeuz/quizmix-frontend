import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/providers/file_picker/pdf_file_provider.dart';
import 'package:quizmix_frontend/state/providers/questions/question_bank_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewer/update_quiz_bank_screen.dart';
import 'package:quizmix_frontend/views/screens/reviewer/uploaded_questions_screen.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_add_questions/upload_buttons_set.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class AddQuestionScreen extends ConsumerWidget {
  const AddQuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionBank = ref.watch(questionBankProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const UpdateQuizBankScreen(),
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
                          const UploadButtonsSet(),
                          const SizedBox(height: 25),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SolidButton(
                                text: 'Cancel',
                                width: 200,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              const SizedBox(width: 25),
                              SolidButton(
                                text: 'Continue',
                                width: 200,
                                onPressed: () {
                                  final aFilePath =
                                      ref.read(pdfFileProvider('a_file')).state;
                                  final qFilePath =
                                      ref.read(pdfFileProvider('q_file')).state;
                                  if (aFilePath != null && qFilePath != null) {
                                    // Upload questions to question bank
                                    questionBank.addQuestionsFromPdf(
                                            aFilePath, qFilePath, ref)
                                        .then((value) => Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const UploadedQuestionsScreen())));
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
        ],
      ),
    );
  }
}
