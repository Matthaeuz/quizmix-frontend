import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/question_attempts/current_question_attempts_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/current_quiz_attempted_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/current_viewed_reviewee_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewee_recent_attempts_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/process_state_provider.dart';
import 'package:quizmix_frontend/views/screens/quiz_attempt_screen.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/view_reviewee_profile/profile_review_attempts_container.dart';

class ViewRevieweeRecentAttemptsModal extends ConsumerStatefulWidget {
  const ViewRevieweeRecentAttemptsModal({Key? key}) : super(key: key);

  @override
  ConsumerState<ViewRevieweeRecentAttemptsModal> createState() =>
      _ViewRevieweeRecentAttemptsModalState();
}

class _ViewRevieweeRecentAttemptsModalState
    extends ConsumerState<ViewRevieweeRecentAttemptsModal> {
  @override
  Widget build(BuildContext context) {
    final client = ref.watch(restClientProvider);
    final token = ref.watch(authTokenProvider).accessToken;
    final reviewee = ref.watch(currentViewedRevieweeProvider);
    final attempts = ref.watch(revieweeRecentAttemptsProvider);
    final processState = ref.watch(processStateProvider);

    return Scaffold(
      appBar: null,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: IntrinsicHeight(
            child: Container(
              width: 800,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        ref
                            .read(modalStateProvider.notifier)
                            .updateModalState(ModalState.none);
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment: Alignment.centerLeft,
                        foregroundColor: AppColors.mainColor,
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            size: 16.0,
                            color: AppColors.mainColor,
                          ),
                          Text('Back to Reviewee Profile'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Recent Attempts",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "by ${reviewee.fullName}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    processState == ProcessState.loading
                        ? const Text(
                            'Preparing Review...',
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColors.mainColor,
                            ),
                          )
                        : const SizedBox(),
                    const SizedBox(height: 8),
                    attempts.when(
                      data: (data) {
                        if (data.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(24),
                              child: EmptyDataPlaceholder(
                                  message: "There are no attempts to show"),
                            ),
                          );
                        }
                        return Column(
                          children: [
                            for (var index = 0;
                                index < data.length;
                                index++) ...[
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
                                          quizAttempt.id ==
                                          currentQuizAttempt.id);
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: InkWell(
                                      onTap: () async {
                                        ref
                                            .read(processStateProvider.notifier)
                                            .updateProcessState(
                                                ProcessState.loading);

                                        ref
                                            .read(currentQuizAttemptedProvider
                                                .notifier)
                                            .updateCurrentQuizAttempted(
                                                currentQuizAttempt,
                                                attemptIndex + 1);

                                        client
                                            .getQuestionAttemptsByQuizAttempt(
                                                token,
                                                data[data.length - index - 1]
                                                    .id)
                                            .then((value) {
                                          ref
                                              .read(
                                                  currentQuestionAttemptsProvider
                                                      .notifier)
                                              .updateCurrentQuestionAttempts(
                                                  value);

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const QuizAttemptScreen(),
                                            ),
                                          );
                                          ref
                                              .read(
                                                  processStateProvider.notifier)
                                              .updateProcessState(
                                                  ProcessState.done);
                                        }, onError: (err) {
                                          ref
                                              .read(
                                                  processStateProvider.notifier)
                                              .updateProcessState(
                                                  ProcessState.done);
                                        });
                                      },
                                      child: ProfileReviewAttemptsContainer(
                                        attempt: currentQuizAttempt,
                                        index: attemptIndex,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ]
                          ],
                        );
                      },
                      error: (error, stack) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: EmptyDataPlaceholder(message: "Error: $error"),
                        ),
                      ),
                      loading: () => const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 32.0,
                                width: 32.0,
                                child: CircularProgressIndicator(),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                'Loading Attempts...',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppColors.mainColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
