import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class AnswerQuizScreen extends StatelessWidget {
  const AnswerQuizScreen({Key? key});

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
            'Answer Quiz',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColors.mainColor,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'Which of the following is the correct decimal fraction equal to hexadecimal fraction 0.248?', // Replace with your actual question text
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Image.network(
                              'lib/assets/images/questions/q1.jpg',
                              width: 800,
                              // height: 150,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'a) 31/32     b) 31/125     c) 31/512     d) 73/512',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          SolidButton(
                            onPressed: () {
                              // Handle choice a button press
                            },
                            text: 'Choice A',
                            width: 150,
                          ),
                          SolidButton(
                            onPressed: () {
                              // Handle choice b button press
                            },
                            text: 'Choice B',
                            width: 150,
                          ),
                          const SizedBox(height: 8),
                          SolidButton(
                            onPressed: () {
                              // Handle choice c button press
                            },
                            text: 'Choice C',
                            width: 150,
                          ),
                          const SizedBox(height: 8),
                          SolidButton(
                            onPressed: () {
                              // Handle choice d button press
                            },
                            text: 'Choice D',
                            width: 150,
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Expanded(
                      child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.mainColor,
                          width: 1.0,
                        ),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 5,
                              crossAxisSpacing: 8.0,
                              mainAxisSpacing: 12.0,
                            ),
                            itemCount: 7,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Text(
                                    '${index + 1}',
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Container(
                                    height: 28,
                                    width: 28,
                                    color: AppColors.fifthColor,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.fourthColor,
                                        padding: EdgeInsets.zero,
                                      ),
                                      child: const SizedBox.shrink(),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ))
                ],
              ),
              const Align(
                alignment: Alignment.bottomRight,
                // child: SolidButton,
              ),
            ],
          ),
        ));
  }
}
