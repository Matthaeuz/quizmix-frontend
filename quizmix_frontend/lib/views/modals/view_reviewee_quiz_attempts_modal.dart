import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/question_attempts/current_question_attempts_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/current_quiz_attempted_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/reviewee_attempts_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_viewed_quiz_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/process_state_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';
import 'package:quizmix_frontend/views/screens/quiz_attempt_screen.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_review_attempts/review_attempts_container.dart';

class ViewRevieweeQuizAttemptsModal extends ConsumerStatefulWidget {
  const ViewRevieweeQuizAttemptsModal({Key? key}) : super(key: key);

  @override
  ConsumerState<ViewRevieweeQuizAttemptsModal> createState() =>
      _ViewRevieweeQuizAttemptsModalState();
}

class _ViewRevieweeQuizAttemptsModalState
    extends ConsumerState<ViewRevieweeQuizAttemptsModal> {
  @override
  Widget build(BuildContext context) {
    final reviewee = ref.watch(userProvider);
    final quiz = ref.watch(currentQuizViewedProvider);
    final attempts = ref.watch(revieweeAttemptsProvider);
    final client = ref.watch(restClientProvider);
    final token = ref.watch(authTokenProvider).accessToken;
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
              child: processState == ProcessState.loading
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(
                                height: 32.0,
                                width: 32.0,
                                child: CircularProgressIndicator(),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                "Preparing Review...",
                                style: TextStyle(
                                  fontSize: 16.0,
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
                                Text('Back to My Quizzes'),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            quiz.title,
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Attempts by ${reviewee.fullName}',
                            style: const TextStyle(fontSize: 16),
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
                                            "There are currently no attempts for this quiz."),
                                  ),
                                );
                              }
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
                                        child: ReviewAttemptsContainer(
                                          attempt: data[index],
                                          index: index,
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
