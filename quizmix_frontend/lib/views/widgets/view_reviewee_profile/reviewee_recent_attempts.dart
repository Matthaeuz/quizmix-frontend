import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/question_attempts/current_question_attempts_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/current_quiz_attempted_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewee_recent_attempts_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/views/screens/quiz_attempt_screen.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/view_reviewee_profile/profile_review_attempts_container.dart';

class RevieweeRecentAttempts extends ConsumerWidget {
  const RevieweeRecentAttempts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(restClientProvider);
    final token = ref.watch(authTokenProvider).accessToken;
    final recentAttempts = ref.watch(revieweeRecentAttemptsProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Recent Attempts",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                ref
                    .read(modalStateProvider.notifier)
                    .updateModalState(ModalState.viewRevieweeRecentAttempts);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,
                foregroundColor: AppColors.mainColor,
              ),
              child: const Text("See All"),
            ),
          ],
        ),
        const SizedBox(height: 8),
        recentAttempts.when(
          data: (data) {
            if (data.isEmpty) {
              return const Expanded(
                child: Center(
                  child: EmptyDataPlaceholder(
                    message: "There are no attempts to show",
                    color: AppColors.mainColor,
                  ),
                ),
              );
            }
            return Expanded(
              child: Column(
                children: [
                  for (var index = 0; index < 3; index++) ...[
                    Builder(
                      builder: (BuildContext context) {
                        final currentQuizAttempt =
                            data[data.length - index - 1];
                        final attemptIndex = data
                            .where((quizAttempt) =>
                                quizAttempt.quiz.id ==
                                currentQuizAttempt.quiz.id)
                            .toList()
                            .indexWhere((quizAttempt) =>
                                quizAttempt.id == currentQuizAttempt.id);
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: InkWell(
                            onTap: () async {
                              ref
                                  .read(modalStateProvider.notifier)
                                  .updateModalState(ModalState.preparingReview);

                              ref
                                  .read(currentQuizAttemptedProvider.notifier)
                                  .updateCurrentQuizAttempted(
                                      currentQuizAttempt, attemptIndex + 1);

                              client
                                  .getQuestionAttemptsByQuizAttempt(
                                      token, data[data.length - index - 1].id)
                                  .then((value) {
                                ref
                                    .read(currentQuestionAttemptsProvider
                                        .notifier)
                                    .updateCurrentQuestionAttempts(value);

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const QuizAttemptScreen(),
                                  ),
                                );
                                ref
                                    .read(modalStateProvider.notifier)
                                    .updateModalState(ModalState.none);
                              }, onError: (err) {
                                ref
                                    .read(modalStateProvider.notifier)
                                    .updateModalState(ModalState.none);
                              });
                            },
                            child: ProfileReviewAttemptsContainer(
                              attempt: currentQuizAttempt,
                              index: attemptIndex,
                              color: AppColors.iconColor,
                            ),
                          ),
                        );
                      },
                    ),
                  ]
                ],
              ),
            );
          },
          error: (err, st) {
            return const Expanded(
              child: Center(
                child: EmptyDataPlaceholder(
                  message: "Please try again later",
                  color: AppColors.mainColor,
                ),
              ),
            );
          },
          loading: () {
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ],
    );
  }
}
