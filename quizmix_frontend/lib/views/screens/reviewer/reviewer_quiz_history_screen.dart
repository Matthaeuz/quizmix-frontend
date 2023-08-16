import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/quiz_attempts/quiz_attempt.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/quiz_attempts_list_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReviewerQuizHistoryScreen extends ConsumerWidget {
  final Quiz quiz;

  const ReviewerQuizHistoryScreen({super.key, required this.quiz});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attempts = ref.read(quizAttemptsListProvider(quiz.id));

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
        body: Container(
            child: attempts.when(
                loading: () => const CircularProgressIndicator(),
                error: (err, stack) => const Text('An error occurred'),
                data: (quizAttempts) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      series: <ChartSeries<QuizAttempt, String>>[
                        ColumnSeries<QuizAttempt, String>(
                          dataSource: quizAttempts,
                          xValueMapper: (QuizAttempt attempt, _) =>
                              'Attempt ${attempt.id}',
                          yValueMapper: (QuizAttempt attempt, _) =>
                              attempt.attemptScore,
                        ),
                      ],
                    ),
                  );
                })));
  }
}
