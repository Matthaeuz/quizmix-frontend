import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/api/base_url_provider.dart';

class AnswerQuizItem extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final baseUrl = ref.watch(baseUrlProvider);
    final choiceLetters = ['A.', 'B.', 'C.', 'D.'];

    return allQuestionsAnswered == true
        ? Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.mainColor,
                width: 1,
              ),
              color: Colors.white,
            ),
            child: const Padding(
              padding: EdgeInsets.all(25),
              child: Text(
                'All questions are answered, please press the submit button',
                style: TextStyle(fontSize: 16),
              ),
            ),
          )
        : Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.mainColor,
                  width: 1,
                ),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: SingleChildScrollView(
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
                      Image.network(
                        baseUrl + image,
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
                            '${choiceLetters[index]} ${choices[index]}',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
