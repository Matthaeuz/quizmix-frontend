import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/quiz_attempts_list_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_view_history/quiz_histogram.dart';

class ReviewerQuizHistoryScreen extends ConsumerWidget {
  final Quiz quiz;

  const ReviewerQuizHistoryScreen({super.key, required this.quiz});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attempts = ref.watch(quizAttemptsListProvider(quiz.id));

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
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
            'Quiz History',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        body: Container(child: QuizHistogram(attempts: attempts)));
  }
}
