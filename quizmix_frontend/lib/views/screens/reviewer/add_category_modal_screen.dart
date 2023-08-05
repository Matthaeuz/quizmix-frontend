import 'package:flutter/material.dart';
import 'package:quizmix_frontend/views/screens/reviewer/update_quiz_bank_screen.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';


class AddCategoryModalScreen extends StatelessWidget {
  const AddCategoryModalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                        const Text(
                          'Add Category',
                          style: TextStyle(fontSize: 24, color: Colors.black),
                        ),
                        const SizedBox(height: 16),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Enter category name',
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
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
                              text: 'Add',
                              width: 200,
                              onPressed: () {
                                // TODO: Implement continue functionality
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
    );
  }
}
