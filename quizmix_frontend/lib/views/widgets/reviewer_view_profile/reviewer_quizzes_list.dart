import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/providers/quizzes/reviewer_quizzes_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_quiz_item_container.dart';

class ReviewerQuizzesList extends ConsumerWidget {
  const ReviewerQuizzesList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzes = ref.watch(reviewerQuizzesProvider);

    return Expanded(
      child: quizzes.when(
        data: (quizzes) => ListView.builder(
          itemCount: quizzes.length,
          itemBuilder: (context, index) {
            final quiz = quizzes[index];
            final totalScore = quiz.questions.length;

            return Column(children: [
              ReviewerQuizItemContainer(
                quizName: quiz
                    .title, // Adjust these fields according to your data model
                totalScore: totalScore.toString(),
                onViewQuizPressed: () {
                  // Add your code for "View Quiz" button pressed
                },
                onViewHistoryPressed: () {
                  // Add your code for "View History" button pressed
                },
              ),
              const SizedBox(height: 16),
            ]);
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
