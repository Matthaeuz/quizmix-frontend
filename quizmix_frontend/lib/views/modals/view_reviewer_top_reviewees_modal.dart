// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/reviewees/current_viewed_reviewee_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewers/reviewer_top_reviewers_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/process_state_provider.dart';
import 'package:quizmix_frontend/views/screens/view_reviewee_profile_screen.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';

class ViewReviewerTopRevieweesModal extends ConsumerStatefulWidget {
  const ViewReviewerTopRevieweesModal({Key? key}) : super(key: key);

  @override
  ConsumerState<ViewReviewerTopRevieweesModal> createState() =>
      _ViewRevieweeRecentFirstAttemptsModalState();
}

class _ViewRevieweeRecentFirstAttemptsModalState
    extends ConsumerState<ViewReviewerTopRevieweesModal> {
  @override
  Widget build(BuildContext context) {
    final processState = ref.watch(processStateProvider);
    
    final revieweesData = ref.watch(reviewerTopRevieweesProvider);

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
                      Text('Back to Dashboard'),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Top Reviewees",
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
                revieweesData.when(
                  data: (data) {
                    if (data.isEmpty) {
                      return const Expanded(
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: EmptyDataPlaceholder(
                              color: AppColors.mainColor,
                              message: "There are no reviewees to show",
                            ),
                          ),
                        ),
                      );
                    }
                    return Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              final revieweeData = data[index];

                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      ref
                                          .read(modalStateProvider.notifier)
                                          .updateModalState(
                                              ModalState.preparingReview);
                                      ref
                                          .read(currentViewedRevieweeProvider
                                              .notifier)
                                          .updateCurrentReviewee(
                                              data[index].user);

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const ViewRevieweeProfileScreen(),
                                        ),
                                      );

                                      ref
                                          .read(modalStateProvider.notifier)
                                          .updateModalState(ModalState.none);
                                    },
                                    child: Container(
                                      height: 60,
                                      padding: const EdgeInsets.fromLTRB(
                                          12, 4, 12, 4),
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
                                                  "${index + 1}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                            flex: 3,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  revieweeData.user.fullName,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
                                                  revieweeData.averageScore
                                                      .toStringAsFixed(2),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                                const Text(
                                                  "Score",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
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
          ),
        ),
      ),
    );
  }
}
