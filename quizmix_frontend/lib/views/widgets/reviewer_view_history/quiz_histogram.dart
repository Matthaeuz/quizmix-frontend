import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quizmix_frontend/state/models/quiz_attempts/quiz_attempt.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class QuizHistogram extends ConsumerWidget {
  final AsyncValue<List<QuizAttempt>> attempts;

  const QuizHistogram({super.key, required this.attempts});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return attempts.when(
          data: (quizAttempts) {
            final Map<int, int> scoreFrequencies = {};
            for (var attempt in quizAttempts) {
              scoreFrequencies[attempt.attemptScore] =
                  (scoreFrequencies[attempt.attemptScore] ?? 0) + 1;
            }

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SfCartesianChart(
                primaryXAxis: NumericAxis(
                    title: AxisTitle(text: 'Attempt Score'),
                    numberFormat: NumberFormat('0'),
                    interval: 1),
                primaryYAxis: NumericAxis(
                    title: AxisTitle(text: 'Frequency'),
                    numberFormat: NumberFormat('0'),
                    interval: 1),
                series: <ChartSeries>[
                  ColumnSeries<MapEntry<int, int>, int>(
                    dataSource: scoreFrequencies.entries.toList(),
                    xValueMapper: (MapEntry<int, int> entry, _) => entry.key,
                    yValueMapper: (MapEntry<int, int> entry, _) => entry.value,
                    name: 'Frequency of Attempt Scores',
                  ),
                ],
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (err, stack) => const Text('An error occurred'),
        );
  }
}