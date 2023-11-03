import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_viewed_quiz_provider.dart';
import 'package:quizmix_frontend/views/widgets/solid_grid_item.dart';

class QuestionGrid extends ConsumerWidget {
  final VoidCallback onPressed;

  const QuestionGrid({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(currentQuizViewedProvider).questions;

    // try intrinsicheight also :))
    return Expanded(
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      border: Border.all(
                        color: AppColors.mainColor,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Wrap(spacing: 8, runSpacing: 8, children: [
                              for (int i = 0; i < questions.length; i++) ...[
                                SolidGridItem(
                                  label: "${i + 1}",
                                  onPressed: onPressed,
                                )
                              ]
                            ])))))));
  }
}
