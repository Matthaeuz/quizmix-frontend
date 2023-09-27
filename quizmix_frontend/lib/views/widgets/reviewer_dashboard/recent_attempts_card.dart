// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/datetime_convert.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/question_attempts/current_question_attempts_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/current_quiz_attempted_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/first_quiz_attempts_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/views/screens/quiz_attempt_screen.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';

class RecentPretestAttemptsCard extends ConsumerWidget {
  const RecentPretestAttemptsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstQuizAttempts = ref.watch(firstQuizAttemptProvider);
    final client = ref.watch(restClientProvider);
    final token = ref.watch(authTokenProvider).accessToken;

    return Consumer(
      builder: (context, watch, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Recent Pretest Attempts',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(modalStateProvider.notifier).updateModalState(
                          ModalState.viewRevieweeRecentFirstAttempts);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.center,
                      foregroundColor: AppColors.mainColor,
                    ),
                    child: const Text("See All"),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              firstQuizAttempts.when(
                data: (data) {
                  return Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: firstQuizAttempts.maybeMap(
                            data: (data) => data.value.length,
                            orElse: () => 0,
                          ),
                          itemBuilder: (BuildContext context, int index) {
                            final int reversedIndex =
                                firstQuizAttempts.maybeMap(
                              data: (data) => data.value.length - 1 - index,
                              orElse: () => 0,
                            );

                            final attempt = firstQuizAttempts.maybeMap(
                              data: (data) => data.value[reversedIndex],
                              orElse: () => null,
                            );

                            return Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    ref
                                        .read(modalStateProvider.notifier)
                                        .updateModalState(
                                            ModalState.preparingReview);

                                    // Update currentQuizAttemptedProvider
                                    ref
                                        .read(currentQuizAttemptedProvider
                                            .notifier)
                                        .updateCurrentQuizAttempted(
                                            attempt, reversedIndex + 1);

                                    // Get question attempts for this quiz attempt
                                    final questionAttempts = await client
                                        .getQuestionAttemptsByQuizAttempt(token,
                                            data[data.length - index - 1].id);

                                    // Update currentQuestionAttemptsProvider
                                    ref
                                        .read(currentQuestionAttemptsProvider
                                            .notifier)
                                        .updateCurrentQuestionAttempts(
                                            questionAttempts);

                                    // Navigate to QuizAttemptScreen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const QuizAttemptScreen(),
                                      ),
                                    );

                                    // Close the modal
                                    ref
                                        .read(modalStateProvider.notifier)
                                        .updateModalState(ModalState.none);
                                  },
                                  child: Container(
                                    height: 60,
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 4, 12, 4),
                                    decoration: BoxDecoration(
                                      color: AppColors.mainColor,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                attempt?.attemptedBy.fullName ??
                                                    '',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                dateTimeToWordDate(
                                                    attempt!.createdOn),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                              Text(
                                                "${dateTimeToTime(attempt.timeStarted)} - ${attempt.timeFinished != null ? dateTimeToTime(attempt.timeFinished!) : "N/A"}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                attempt.quiz.title,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                              const Text(
                                                "Attempt No. 1",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "${attempt.attemptScore.toString()} / ${attempt.quiz.questions.length}",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w400,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                              const Text(
                                                "Score",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: AppColors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                )
                              ],
                            );
                          }));
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
          ),
        );
      },
    );
  }
}
