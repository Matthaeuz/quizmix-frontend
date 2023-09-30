import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/datetime_convert.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/providers/quizzes/cat_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_taken_quiz_provider.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/current_quiz_attempted_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_viewed_quiz_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewee/answer_quiz_screen.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class RevieweeQuizItem extends ConsumerWidget {
  final Quiz quiz;

  const RevieweeQuizItem({super.key, required this.quiz});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewee = ref.read(userProvider);
    final client = ref.watch(restClientProvider);
    final token = ref.watch(authTokenProvider).accessToken;

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 352,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppColors.fourthColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: quiz.image != null
                        ? Image(
                            image: NetworkImage(quiz.image!),
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Text(
                              quiz.title[0],
                              style: const TextStyle(
                                color: AppColors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quiz.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${quiz.numQuestions} ${quiz.numQuestions > 1 ? "questions" : "question"}, ${quiz.numCategories} ${quiz.numCategories > 1 ? "categories" : "category"}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Created on: ${dateTimeToWordDate(quiz.createdOn)}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: SolidButton(
                    onPressed: () {
                      ref
                          .read(currentQuizViewedProvider.notifier)
                          .updateCurrentQuiz(quiz);
                      ref.read(modalStateProvider.notifier).updateModalState(
                          ModalState.viewRevieweeQuizAttempts);
                    },
                    text: 'Review Attempts',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SolidButton(
                    onPressed: () async {
                      ref
                          .read(modalStateProvider.notifier)
                          .updateModalState(ModalState.preparingQuiz);

                      final hasAttempts =
                          await client.getRevieweeAttemptsByQuiz(
                              token, reviewee.id, quiz.id);
                      ref
                          .read(currentTakenQuizProvider.notifier)
                          .updateCurrentQuiz(quiz);
                      ref
                          .read(currentTakenQuizProvider.notifier)
                          .updateScore(0);

                      // make QuizAttempt for either pretest & adaptive test
                      Map<String, int> details = {
                        "attempted_by": reviewee.id,
                        "quiz": quiz.id,
                      };

                      client.createQuizAttempt(token, details).then((value) {
                        ref
                            .read(currentQuizAttemptedProvider.notifier)
                            .updateCurrentQuizAttempted(
                                value,
                                hasAttempts.isEmpty
                                    ? 1
                                    : hasAttempts.length + 1);

                        if (hasAttempts.isNotEmpty) {
                          ref.read(catProvider.notifier).initializeCAT();
                        }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AnswerQuizScreen()));
                        ref
                            .read(modalStateProvider.notifier)
                            .updateModalState(ModalState.none);
                      }, onError: (err) {
                        ref
                            .read(modalStateProvider.notifier)
                            .updateModalState(ModalState.none);
                      });
                    },
                    text: 'Answer Quiz',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
