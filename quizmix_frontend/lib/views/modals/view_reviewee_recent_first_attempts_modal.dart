import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/datetime_convert.dart';
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
import 'package:quizmix_frontend/state/providers/quiz_attempts/first_quiz_attempts_provider.dart';

class ViewRevieweeRecentFirstAttemptsModal extends ConsumerStatefulWidget {
  const ViewRevieweeRecentFirstAttemptsModal({Key? key}) : super(key: key);

  @override
  ConsumerState<ViewRevieweeRecentFirstAttemptsModal> createState() =>
      _ViewRevieweeRecentFirstAttemptsModalState();
}

class _ViewRevieweeRecentFirstAttemptsModalState
    extends ConsumerState<ViewRevieweeRecentFirstAttemptsModal> {
  @override
  Widget build(BuildContext context) {
    final processState = ref.watch(processStateProvider);
    final firstQuizAttempts = ref.watch(firstQuizAttemptProvider);

    return Scaffold(
      appBar: null,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            width: 800,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
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
                  "Recent Pretest Attempts",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                processState == ProcessState.loading
                    ? const Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: Text(
                          'Preparing Review...',
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.mainColor,
                          ),
                        ),
                      )
                    : const SizedBox(),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: firstQuizAttempts.maybeMap(
                        data: (data) => data.value.length,
                        orElse: () => 0,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        final int reversedIndex = firstQuizAttempts.maybeMap(
                          data: (data) => data.value.length - 1 - index,
                          orElse: () => 0,
                        );

                        final attempt = firstQuizAttempts.maybeMap(
                          data: (data) => data.value[reversedIndex],
                          orElse: () => null,
                        );
                        return Column(
                          children: [
                            Container(
                              height: 60,
                              padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          attempt?.attemptedBy.fullName ?? '',
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
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          dateTimeToWordDate(attempt!.createdOn),
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
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
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
                            const SizedBox(
                              height: 15,
                            )
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
