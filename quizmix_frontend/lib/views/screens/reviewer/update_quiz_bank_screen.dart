import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/categories.constants.dart';
// import 'package:quizmix_frontend/views/screens/Reviewer/add_question_screen.dart';
import 'package:quizmix_frontend/views/screens/reviewer/update_quiz_bank_details_screen.dart';
import 'package:quizmix_frontend/views/screens/reviewer/add_question_screen.dart';
import 'dart:math';

import 'package:quizmix_frontend/views/widgets/tiny_solid_button.dart';

class UpdateQuizBankScreen extends ConsumerWidget {
  const UpdateQuizBankScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Question Bank',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  'Select Category',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'Poppins',
                  ),
                ),
                const Spacer(),
                TinySolidButton(
                  text: 'Delete Category',
                  icon: Icons.delete,
                  buttonColor: Colors.red,
                  onPressed: () {
                    // Handle Delete Category press
                  },
                ),
                const SizedBox(width: 10),
                TinySolidButton(
                  text: 'Add Question',
                  icon: Icons.add,
                  buttonColor: const Color(0xFF03045E),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddQuestionScreen(),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 10),
                TinySolidButton(
                  text: 'Add Category',
                  icon: Icons.add,
                  buttonColor: const Color(0xFF03045E),
                  onPressed: () {
                    // Handle Add Category press
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 25,
                      mainAxisSpacing: 25,
                      childAspectRatio: 5,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        UpdateQuizBankDetailsScreen(
                                          categoryColor:
                                              getCategoryColor(index),
                                          categoryTitle: categories[index],
                                        )));
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: getCategoryColor(index),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(categories[index],
                              style: const TextStyle(fontFamily: 'Poppins')),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color getCategoryColor(int index) {
    switch (index) {
      case 0:
        return const Color(0xFF9854B2);
      case 1:
        return const Color(0xFFCF4321);
      case 2:
        return const Color(0xFFC92D5C);
      case 3:
        return const Color(0xFF0D2916);
      case 4:
        return const Color(0xFF3371E4);
      case 5:
        return const Color(0xFF75A768);
      case 6:
        return const Color(0xFF8768A7);
      case 7:
        return const Color(0xFF223160);
      case 8:
        return const Color(0xFF678026);
      case 9:
        return const Color(0xFF282680);
      default:
        return getRandomColor();
    }
  }

  Color getRandomColor() {
    final random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1,
    );
  }
}
