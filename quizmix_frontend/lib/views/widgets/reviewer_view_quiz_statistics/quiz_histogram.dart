import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
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

        // Print the values received by the histogram
        print("Score Frequencies: $scoreFrequencies");

        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(
              title: AxisTitle(
                text: 'Attempt Score',
                textStyle: const TextStyle(color: AppColors.white),
              ),
              interval: 1,
              labelStyle: const TextStyle(color: AppColors.white),
            ),
            primaryYAxis: NumericAxis(
              title: AxisTitle(
                text: 'Frequency',
                textStyle: const TextStyle(color: AppColors.white),
              ),
              numberFormat: NumberFormat('0'),
              interval: 1,
              labelStyle: const TextStyle(color: AppColors.white),
            ),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries>[
              ColumnSeries<MapEntry<int, int>, String>(
                dataSource: scoreFrequencies.entries.toList(),
                xValueMapper: (MapEntry<int, int> entry, _) =>
                    entry.key.toString(),
                yValueMapper: (MapEntry<int, int> entry, _) => entry.value,
                name: 'Frequency of Attempt Scores',
                color: AppColors.thirdColor,
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
