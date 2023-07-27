import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';

class AnswerQuizItem extends StatelessWidget {
  final String question;
  final String image;
  final List<String> choices;
  final bool? allQuestionsAnswered;

  AnswerQuizItem({
    required this.question,
    required this.image,
    required this.choices,
    this.allQuestionsAnswered,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.mainColor,
          width: 1,
        ),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Visibility(
              visible: !(allQuestionsAnswered == true),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      question,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.5,
                    ),
                    child: SingleChildScrollView(
                      child: Image.network(
                        image,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Choices',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: choices.length,
                    itemBuilder: (context, index) {
                      return Text(
                        choices[index],
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Visibility(
              visible: allQuestionsAnswered == true,
              child: const Text(
                'All questions are answered, please press the submit button',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
