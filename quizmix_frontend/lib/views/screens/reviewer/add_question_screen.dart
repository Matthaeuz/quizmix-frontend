import 'package:flutter/material.dart';
import 'package:quizmix_frontend/views/screens/reviewer/update_quiz_bank_screen.dart';
import 'package:quizmix_frontend/views/screens/reviewer/uploaded_questions_screen.dart';
import 'package:quizmix_frontend/views/widgets/pdf_input_button.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class AddQuestionScreen extends StatelessWidget {
  const AddQuestionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                                ),
                              ),
                              SizedBox(width: 25),
                              Expanded(
                                  child: PdfInputButton(
                                buttonText: 'Upload Answer Set',
                                buttonIcon: Icons.upload,
                                buttonTextSize: 16,
                                buttonIconSize: 100,
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UploadedQuestionsScreen()));
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
