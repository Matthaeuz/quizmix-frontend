import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/quiz_attempts/quiz_attempt.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/question_attempts/current_question_attempts_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/current_quiz_attempted_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/current_quiz_list_attempts_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/process_state_provider.dart';
import 'package:quizmix_frontend/views/screens/quiz_attempt_screen.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_view_quiz_statistics/quiz_statistics_all_attempts_container.dart';

List<int> calculateAttemptIndexes(List<QuizAttempt> attempts) {
  final attemptIndexes = <int>[];

  // Group attempts by attemptedBy to sort them by reviewee
  final attemptsGroupedByReviewee = <int, List<QuizAttempt>>{};
  for (final attempt in attempts) {
    final revieweeId = attempt.attemptedBy.id;
    if (!attemptsGroupedByReviewee.containsKey(revieweeId)) {
      attemptsGroupedByReviewee[revieweeId] = [];
    }
    attemptsGroupedByReviewee[revieweeId]!.add(attempt);
  }

  // Sort attempts for each reviewee and add their attempt numbers
  attemptsGroupedByReviewee.forEach((revieweeId, revieweeAttempts) {
    revieweeAttempts.sort((a, b) => a.createdOn.compareTo(b.createdOn));
    for (var i = 0; i < revieweeAttempts.length; i++) {
      attemptIndexes.add(i);
    }
  });

  return attemptIndexes;
}

class ViewAllQuizAttemptsModal extends ConsumerStatefulWidget {
  const ViewAllQuizAttemptsModal({Key? key}) : super(key: key);

  @override
  ConsumerState<ViewAllQuizAttemptsModal> createState() =>
      _ViewAllQuizAttemptsModalState();
}

class _ViewAllQuizAttemptsModalState
    extends ConsumerState<ViewAllQuizAttemptsModal> {
  @override
  Widget build(BuildContext context) {
    final client = ref.watch(restClientProvider);
    final token = ref.watch(authTokenProvider).accessToken;
    final attempts = ref.watch(currentQuizListAttemptsProvider);
    final processState = ref.watch(processStateProvider);

    return Scaffold(
      appBar: null,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: IntrinsicHeight(
            child: Container(
              width: processState == ProcessState.loading ? 400 : 800,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: processState == ProcessState.loading
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(24, 48, 24, 48),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 48.0,
                                width: 48.0,
                                child:
                                    CircularProgressIndicator(strokeWidth: 6.0),
                              ),
                              SizedBox(height: 16.0),
                              Text(
                                "Preparing Review...",
                                style: TextStyle(
                                  fontSize: 24.0,
                                  color: AppColors.mainColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
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
                                Text('Back to Quiz Statistics'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          attempts.when(
                            data: (data) {
                              if (data.isEmpty) {
                                return const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(24),
                                    child: EmptyDataPlaceholder(
                                      message:
                                          "There are currently no attempts for this quiz",
                                      color: AppColors.mainColor,
                                    ),
                                  ),
                                );
                              }
                              final attemptIndexes =
                                  calculateAttemptIndexes(data);
                              return Column(
                                children: [
                                  for (var index = 0;
                                      index < data.length;
                                      index++) ...[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 12.0),
                                      child: InkWell(
                                        onTap: () async {
                                          ref
                                              .read(
                                                  processStateProvider.notifier)
                                              .updateProcessState(
                                                  ProcessState.loading);

                                          ref
                                              .read(currentQuizAttemptedProvider
                                                  .notifier)
                                              .updateCurrentQuizAttempted(
                                                  data[index], index + 1);

                                          client
                                              .getQuestionAttemptsByQuizAttempt(
                                                  token, data[index].id)
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
                                                .read(processStateProvider
                                                    .notifier)
                                                .updateProcessState(
                                                    ProcessState.done);
                                          }, onError: (err) {
                                            ref
                                                .read(processStateProvider
                                                    .notifier)
                                                .updateProcessState(
                                                    ProcessState.done);
                                          });
                                        },
                                        child:
                                            QuizStatisticsAllAttemptsContainer(
                                          attempt: data[index],
                                          index: attemptIndexes[index],
                                          color: AppColors.iconColor,
                                        ),
                                      ),
                                    )
                                  ]
                                ],
                              );
                            },
                            error: (error, stack) => Center(
                              child: Padding(
                                padding: const EdgeInsets.all(24),
                                child: EmptyDataPlaceholder(
                                    message: "Error: $error"),
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
