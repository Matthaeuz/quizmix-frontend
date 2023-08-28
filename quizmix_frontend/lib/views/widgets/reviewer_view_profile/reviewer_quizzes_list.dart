import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_taken_quiz_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_viewed_quiz_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/reviewer_quizzes_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewer/reviewer_quiz_history_screen.dart';
import 'package:quizmix_frontend/views/screens/reviewer/view_quiz_screen.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart'; // Import the widget
import 'package:quizmix_frontend/views/widgets/reviewer_quiz_item_container.dart';

class ReviewerQuizzesList extends ConsumerWidget {
  const ReviewerQuizzesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzes = ref.watch(reviewerQuizzesProvider);

    return Expanded(
      child: quizzes.when(
        data: (quizzes) => quizzes.isEmpty
            ? const Expanded(
                child: EmptyDataPlaceholder(
                message: "There are currently no quizzes available.",
                iconSize: 100,
                fontSize: 18,
              ))
            : ListView.builder(
                reverse: true,
                itemCount: quizzes.length,
                itemBuilder: (context, index) {
                  final quiz = quizzes[index];
                  final totalScore = quiz.questions.length;

                  return Column(children: [
                    ReviewerQuizItemContainer(
                      quizName: quiz.title,
                      totalScore: totalScore.toString(),
                      onViewQuizPressed: () {
                        ref
                            .read(currentQuizViewedProvider.notifier)
                            .updateCurrentQuiz(quiz);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ViewQuizScreen()));
                      },
                      onViewHistoryPressed: () {
                        ref
                            .read(currentTakenQuizProvider.notifier)
                            .updateCurrentQuiz(quiz);
                        ref
                            .read(currentTakenQuizProvider.notifier)
                            .updateScore(0);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ReviewerQuizHistoryScreen(quiz: quiz)));
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
