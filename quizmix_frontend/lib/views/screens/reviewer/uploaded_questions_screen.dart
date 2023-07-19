import 'package:flutter/material.dart';
import 'package:quizmix_frontend/models/question_details.dart';
import 'package:quizmix_frontend/views/widgets/tiny_solid_button.dart';
import 'package:quizmix_frontend/views/widgets/uploaded_question_item_container.dart';

class UploadedQuestionsScreen extends StatelessWidget {
  UploadedQuestionsScreen({Key? key}) : super(key: key);

  // final List<String> categories = [
  //   'Algorithms and Programming',
  //   'Computer Components and Hardware',
  //   'System Components',
  //   'Software',
  //   'Development Technology and Management',
  //   'Database',
  //   'Network',
  //   'Security',
  //   'System Audit, Strategy and Planning',
  //   'Business, Corporate & Legal Affairs'
  // ];

  final List<QuestionDetails> questionDetails = [
    QuestionDetails(
        category: 'Algorithms and Programming',
        questionText:
            'Which of the following is the correct decimal fraction equal to hexadecimal fraction 0.248?',
        imagePath: 'lib/assets/images/questions/Q1.jpg',
        choices: ['a) 31/32', 'b) 31/125', 'c) 31/512', 'd) 73/512'],
        answer: 'c) 31/512'),
    QuestionDetails(
        category: 'Computer Components and Hardware',
        questionText:
            'Which of the following is the correct value of the quadruple of hexadecimal fraction 0.FEDC?',
        imagePath: 'lib/assets/images/questions/Q2.jpg',
        choices: ['a) 1.FDB8', 'b) 2.FB78', 'c) 3.FB70', 'd) F.EDC0'],
        answer: 'a) 1.FDB8'),
    QuestionDetails(
        category: 'System Components',
        questionText:
            'In a floating-point number format, which of the following is the correct operation for adjusting the radix point and the exponent so that the most significant digit of the mantissa can be a non-zero value? Here, an absolute value is used for the mantissa.',
        imagePath: 'lib/assets/images/questions/Q3.jpg',
        choices: ['a) Carry', 'b) Normalize', 'c) Round down', 'd) Round up'],
        answer: 'd) Round up'),
    QuestionDetails(
        category: 'Software',
        questionText:
            'The decimal value "-72" is stored in an 8-bit register using 2/s complement. If the data is the register is logically shifter two bits to the right, which of the following is the correct result that is represented in decimal?',
        imagePath: 'lib/assets/images/questions/Q4.jpg',
        choices: ['a) -19', 'b) -18', 'c) 45', 'd) 46'],
        answer: 'd) 46'),
    QuestionDetails(
        category: 'Development Technology and Management',
        questionText:
            'By definition of the IEEE754 standard, 32-bit floating point numbers are represented as follows: S(1 bit) E(8 bits) M(23 bits) S: Sign bit E: Exponent M: Mantissa Which of the following is the correct "mask bits" in hexadecimal to be used for extracting only the exponent part of the above format? Here, "mask bits" means a bit pattern which is logically ANDed with the 32-bit floating point value.',
        imagePath: 'lib/assets/images/questions/Q5.jpg',
        choices: ['a) 107FFFFF', 'b) 7F800000', 'c) FF100000', 'd) FF800000'],
        answer: 'b) 7F800000'),
  ];

  @override
  Widget build(BuildContext context) {
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
          'Uploaded Questions Screen',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
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
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12.0),
                shrinkWrap: true,
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  final details = questionDetails[index];
                  return UploadedQuestionItemContainer(
                    questionDetails: details,
                    index: index,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
