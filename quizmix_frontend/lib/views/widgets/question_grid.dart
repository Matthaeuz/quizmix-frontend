import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_viewed_quiz_provider.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class QuestionGrid extends ConsumerWidget {
  final VoidCallback onPressed;

  const QuestionGrid({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(currentQuizViewedProvider).questions;
    final screenWidth = MediaQuery.of(context).size.width;
    const int minCols = 1;
    const int maxCols = 5;
    final int cols = (screenWidth / 8).floor();
    int finalCols = cols.clamp(minCols, maxCols);

    return Expanded(
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
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: finalCols,
                            crossAxisSpacing: 60,
                            mainAxisSpacing: 20,
                          ),
                          itemCount: questions.length,
                          itemBuilder: (context, index) {
                            return SizedBox(
                                child: SolidButton(
                                    text: "${index + 1}",
                                    onPressed: onPressed));
                          },
                        ))))));
  }
}
