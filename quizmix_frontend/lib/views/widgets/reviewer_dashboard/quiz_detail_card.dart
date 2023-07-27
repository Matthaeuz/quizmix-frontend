import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_viewed_quiz_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewer/view_quiz_screen.dart';

class QuizDetailCard extends ConsumerWidget {
  final Quiz quiz;

  const QuizDetailCard({super.key, required this.quiz});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String firstLetter = quiz.title[0];

    return GestureDetector(
      onTap: () {
        ref.read(currentQuizViewedProvider.notifier).updateCurrentQuiz(quiz);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ViewQuizScreen()));
      },
      child: Container(
        width: 200,
        height: 200,
        color: Colors.white,
        margin: const EdgeInsets.only(right: 25),
        padding: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: quiz.image == null
                      ? Text(
                          firstLetter.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      : Image.network(
                          quiz.image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    quiz.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
