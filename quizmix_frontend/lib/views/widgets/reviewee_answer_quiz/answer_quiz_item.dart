import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/base_url_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_taken_quiz_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewee/view_quiz_result_screen.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class AnswerQuizItem extends ConsumerWidget {
  final Question? question;
  final int currentQuestionIndex;
  final bool allQuestionsAnswered;
  final bool isPretest;
  final Function() onEnd;

  const AnswerQuizItem({
    super.key,
    required this.question,
    required this.currentQuestionIndex,
    required this.allQuestionsAnswered,
    required this.isPretest,
    required this.onEnd,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseUrl = ref.watch(baseUrlProvider);
    final choiceLetters = ['A.', 'B.', 'C.', 'D.'];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: allQuestionsAnswered
            ? Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Quiz Completed!',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: AppColors.mainColor,
                        ),
                      ),
                      Text(
                        'Your score is ${ref.read(currentTakenQuizProvider.notifier).score}/${ref.read(currentTakenQuizProvider).questions.length}',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SolidButton(
                            width: 148,
                            text: 'Finish',
                            onPressed: () {
                              onEnd();
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(width: 24.0),
                          SolidButton(
                            width: 148,
                            text: 'Review',
                            onPressed: () {
                              onEnd();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ViewQuizResultScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : question == null
                ? const Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 48.0,
                            width: 48.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 6.0,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            "Selecting next question...",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            onEnd();
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            alignment: Alignment.centerLeft,
                            foregroundColor: AppColors.mainColor,
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.arrow_back,
                                size: 16.0,
                                color: AppColors.mainColor,
                              ),
                              Text('Back to Home'),
                            ],
                          ),
                        ),
                        Text(
                          isPretest ? "Answer Quiz" : "Answer Adaptive Quiz",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Question No. ${currentQuestionIndex + 1}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          question!.question,
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 24),
                        question!.image != null
                            ? Image.network(
                                question!.image!.contains(baseUrl)
                                    ? question!.image!
                                    : baseUrl + question!.image!,
                              )
                            : const SizedBox(),
                        question!.image != null
                            ? const SizedBox(height: 24)
                            : const SizedBox(),
                        const Text(
                          'Choices',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: question!.choices.length,
                          itemBuilder: (context, index) {
                            return Text(
                              '${choiceLetters[index]} ${question!.choices[index]}',
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
      ),
    );
  }
}
