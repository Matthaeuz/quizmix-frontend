import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_category_questions/category_questions_list.dart';
import 'package:quizmix_frontend/views/widgets/tiny_solid_button.dart';

class UpdateQuizBankDetailsScreen extends ConsumerWidget {
  final Color categoryColor;
  final String title;

  const UpdateQuizBankDetailsScreen(
      {Key? key, required this.categoryColor, required this.title})
      : super(key: key);

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
        title: Row(
          children: [
            const Text(
              'Question Bank',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 25.0),
              padding: const EdgeInsets.all(10.0),
              height: 40,
              decoration: BoxDecoration(
                color: categoryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: 400,
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                TinySolidButton(
                  text: 'Add Question',
                  buttonColor: const Color(0xFF03045E),
                  onPressed: () {
                    // Handle Add Question press
                  },
                  icon: Icons.add,
                ),
              ],
            ),
            const SizedBox(height: 10),
            CategoryQuestionsList(title: title),
          ],
        ),
      ),
    );
  }
}
