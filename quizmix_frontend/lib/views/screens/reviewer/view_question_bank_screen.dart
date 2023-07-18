import 'package:flutter/material.dart';
import 'package:quizmix_frontend/models/question_details.dart';
import 'package:quizmix_frontend/views/screens/reviewer/update_quiz_bank_screen.dart';
import 'package:quizmix_frontend/views/widgets/dashboard.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';
import 'package:quizmix_frontend/views/widgets/view_question_bank_card.dart';

class ViewQuestionBankScreen extends StatelessWidget {
  final List<QuestionDetails> questionDetails = [
    QuestionDetails(
        category: 'Algorithms and Programming',
        questionText:
            'Which of the following is the correct decimal fraction equal to hexadecimal fraction 0.248?',
        imagePath: 'lib/assets/images/questions/Q1.jpg',
        choices: ['a) 31/32', 'b) 31/125', 'c) 31/512', 'd) 73/512'],
        answer: 'd) 73/512',
        explanation:
            '''The hexadecimal fraction 0.248 can be converted to a decimal fraction by dividing each digit by the corresponding power of 16. In this case, the digit '2' is in the position of 16^(-1), '4' is in the position of 16^(-2), and '8' is in the position of 16^(-3).

To convert 0.248 to a decimal fraction, we can calculate as follows:

0.248 = (2/16^1) + (4/16^2) + (8/16^3)

Simplifying the expression, we get:

0.248 = (2/16) + (4/256) + (8/4096)
= 1/8 + 1/64 + 1/512
= 64/512 + 8/512 + 1/512
= (64 + 8 + 1)/512
= 73/512

Therefore, the correct decimal fraction equivalent to the hexadecimal fraction 0.248 is 73/512.'''),
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

  ViewQuestionBankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Side - Dashboard
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: const Column(
                children: [
                  // Left Side - Dashboard
                  DashboardWidget(
                    selectedOption: 'Question Bank',
                  ),
                ],
              ),
            ),
          ),
          // Middle Area
          Expanded(
            flex: 3,
            child: Container(
              color: const Color(0xFFCAF0F8),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Flexible(
                            flex: 1,
                            child: FractionallySizedBox(
                              widthFactor: 0.9, // Adjust this value as needed
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
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10),
                                ),
                              ),
                            ),
                          ),
                          ButtonSolid(
                            text: 'Update',
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          UpdateQuizBankScreen()));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount:
                                  5, // Replace with the actual number of items
                              itemBuilder: (context, index) {
                                return ViewQuestionBankCard(
                                  questionDetails: questionDetails[index],
                                  index: index,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right Area
          Expanded(
            flex: 5,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  color: const Color(0xFF90E0EF),
                  height: constraints
                      .maxHeight, // Set the height to fill the available space
                  child: const SingleChildScrollView(
                    child: Column(
                      children: [Text('data2')],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
