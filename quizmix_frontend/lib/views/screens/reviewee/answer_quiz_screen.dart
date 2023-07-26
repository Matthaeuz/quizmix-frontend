import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_answer_quiz/answer_quiz_item.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class AnswerQuizScreen extends StatefulWidget {
  final List<Map<String, dynamic>>? questionsData;
  final int? currentQuestionIndex;

  AnswerQuizScreen({
    this.questionsData,
    this.currentQuestionIndex,
  });

  @override
  _AnswerQuizScreenState createState() => _AnswerQuizScreenState();
}

class _AnswerQuizScreenState extends State<AnswerQuizScreen> {
  int currentQuestionIndex = 0;
  bool allQuestionsAnswered = false;
  

  final List<Map<String, dynamic>> questionsData = [
    {
      'question':
          'Which of the following is the correct decimal fraction equal to hexadecimal fraction 0.248?',
      'image': 'lib/assets/images/questions/q1.jpg',
      'choices': [
        'a) 31/32',
        'b) 31/125',
        'c) 31/512',
        'd) 73/512',
      ],
    },
    {
      'question':
          'Which of the following is the correct decimal fraction equal to hexadecimal fraction 0.248?',
      'image': 'lib/assets/images/questions/q2.jpg',
      'choices': [
        'a) 31/32',
        'b) 31/125',
        'c) 31/512',
        'd) 73/512',
      ],
    },
    {
      'question':
          'Which of the following is the correct decimal fraction equal to hexadecimal fraction 0.248?',
      'image': 'lib/assets/images/questions/q3.jpg',
      'choices': [
        'a) 31/32',
        'b) 31/125',
        'c) 31/512',
        'd) 73/512',
      ],
    },
    {
      'question':
          'Which of the following is the correct decimal fraction equal to hexadecimal fraction 0.248?',
      'image': 'lib/assets/images/questions/q4.jpg',
      'choices': [
        'a) 31/32',
        'b) 31/125',
        'c) 31/512',
        'd) 73/512',
      ],
    },
    {
      'question':
          'Which of the following is the correct decimal fraction equal to hexadecimal fraction 0.248?',
      'image': 'lib/assets/images/questions/q5.jpg',
      'choices': [
        'a) 31/32',
        'b) 31/125',
        'c) 31/512',
        'd) 73/512',
      ],
    },
  ];

  void handleChoicePressed() {
    setState(() {
      if (currentQuestionIndex >= questionsData.length - 1) {
        print("Already at the last question");
        allQuestionsAnswered = true;
        // Modify here Rowny so that it will navigate to the next screen for integration
        Navigator.pop(context);
        return;
      } else {
        currentQuestionIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> currentQuestion = questionsData[currentQuestionIndex];

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
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left side
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnswerQuizItem(
                            question: currentQuestion['question'],
                            image: currentQuestion['image'],
                            choices: currentQuestion['choices'],
                            allQuestionsAnswered: allQuestionsAnswered),
                        const SizedBox(height: 25),
                        Row(
                          children: [
                            Expanded(
                              child: SolidButton(
                                onPressed: handleChoicePressed,
                                isUnpressable: allQuestionsAnswered,
                                text: 'Choice A',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SolidButton(
                                onPressed: handleChoicePressed,
                                isUnpressable: allQuestionsAnswered,
                                text: 'Choice B',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SolidButton(
                                onPressed: handleChoicePressed,
                                isUnpressable: allQuestionsAnswered,
                                text: 'Choice C',
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: SolidButton(
                                onPressed: handleChoicePressed,
                                isUnpressable: allQuestionsAnswered,
                                text: 'Choice D',
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  // Right Side
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.mainColor,
                          width: 1.0,
                        ),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 3),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double gridWidth = constraints.maxWidth * 0.1;
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 70,
                              crossAxisSpacing: 12.0,
                              mainAxisSpacing: 12.0,
                            ),
                            itemCount: questionsData.length,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: gridWidth,
                                child: Column(
                                  children: [
                                    Material(
                                      color: Colors.transparent,
                                      child: GestureDetector(
                                        onTap:
                                            () {}, // No action on tap, making it non-pressable
                                        child: Container(
                                          width: gridWidth,
                                          height: gridWidth,
                                          color: allQuestionsAnswered
                                              ? const Color.fromARGB(
                                                  115, 158, 158, 158)
                                              : currentQuestionIndex == index
                                                  ? AppColors.mainColor
                                                  : currentQuestionIndex > index
                                                      ? const Color.fromARGB(
                                                          115, 158, 158, 158)
                                                      : AppColors.thirdColor,
                                          child: Center(
                                            child: Text(
                                              '${index + 1}',
                                              style: TextStyle(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.01,
                                                color: allQuestionsAnswered ||
                                                        currentQuestionIndex ==
                                                            index
                                                    ? Colors.white
                                                    : currentQuestionIndex >
                                                            index
                                                        ? Colors.white
                                                        : AppColors.mainColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomRight,
                child: SolidButton(
                  onPressed: () {},
                  text: 'Submit',
                  width: 150,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
