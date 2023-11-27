import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/quiz_attempts/quiz_attempt.dart';
import 'package:quizmix_frontend/state/models/quiz_attempts/score_details.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class QuizHistogram extends ConsumerWidget {
  final AsyncValue<List<QuizAttempt>> attempts;

  const QuizHistogram({super.key, required this.attempts});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return attempts.when(
      data: (quizAttempts) {
        final Map<int, ScoreDetail> scoreDetails = {};
        for (var attempt in quizAttempts) {
          scoreDetails.putIfAbsent(attempt.attemptScore,
              () => ScoreDetail(attempt.attemptScore, 0, []));
          scoreDetails[attempt.attemptScore]!.frequency += 1;
          scoreDetails[attempt.attemptScore]!
              .names
              .add(attempt.attemptedBy.fullName);
        }

        final sortedData = scoreDetails.values.toList()
          ..sort((a, b) => a.score.compareTo(b.score));

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
            onTooltipRender: (TooltipArgs args) {
              int score = args.dataPoints![args.pointIndex!.toInt()].x.toInt();
              List<String> names = scoreDetails[score]?.names ?? [];
              String formattedNames = names.map((name) => '• $name').join('\n');

              args.text = 'Score: $score\nNames:\n$formattedNames';
            },
            series: <ChartSeries>[
              ColumnSeries<ScoreDetail, int>(
                dataSource: sortedData,
                xValueMapper: (ScoreDetail details, _) => details.score,
                yValueMapper: (ScoreDetail details, _) => details.frequency,
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
