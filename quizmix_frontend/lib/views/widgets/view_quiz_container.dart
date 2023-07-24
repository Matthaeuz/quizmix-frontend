import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class ViewQuizContainer extends ConsumerWidget {
  const ViewQuizContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      flex: 5,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            color: AppColors.fourthColor,
            height: constraints.maxHeight,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.zero,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Text(
                                  'Question 1',
                                  style: TextStyle(fontSize: 32),
                                ),
                                const SizedBox(width: 15),
                                Align(
                                  // Wrap the Flexible with Align
                                  alignment: Alignment.centerLeft,
                                  child: Flexible(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 12,
                                      ),
                                      decoration: BoxDecoration(
                                        color: getCategoryColor(
                                            'Algorithms and Programming'),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: const Text(
                                        'Algorithms and Programming',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                SolidButton(
                                  text: 'Remove',
                                  onPressed: () {
                                    // Add your code for handling "Remove" press here
                                  },
                                  icon: const Icon(Icons.delete),
                                  backgroundColor: Colors.red,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          Image.network(
                            'lib/assets/images/questions/q1.jpg',
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'The correct answer is "d) 73/512"',
                            style: TextStyle(fontSize: 28),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Explanation:',
                            style: TextStyle(fontSize: 28),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            '''The hexadecimal fraction 0.248 can be converted to a decimal fraction by dividing each digit by the corresponding power of 16. In this case, the digit '2' is in the position of 16^(-1), '4' is in the position of 16^(-2), and '8' is in the position of 16^(-3).

To convert 0.248 to a decimal fraction, we can calculate as follows:

0.248 = (2/16^1) + (4/16^2) + (8/16^3)

Simplifying the expression, we get:

0.248 = (2/16) + (4/256) + (8/4096)
= 1/8 + 1/64 + 1/512
= 64/512 + 8/512 + 1/512
= (64 + 8 + 1)/512
= 73/512

Therefore, the correct decimal fraction equivalent to the hexadecimal fraction 0.248 is 73/512.''',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
