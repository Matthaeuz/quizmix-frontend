// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/reviewees/current_viewed_reviewee_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewers/reviewer_top_reviewers_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/views/screens/view_reviewee_profile_screen.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';

class TopRevieweesCard extends ConsumerWidget {
  const TopRevieweesCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final revieweesData = ref.watch(reviewerTopRevieweesProvider);

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
                    'Top Reviewees',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(modalStateProvider.notifier).updateModalState(
                          ModalState.viewReviewerTopReviewees);
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
                                                "${index + 1}",
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
                                                revieweeData.averageScore
                                                    .toStringAsFixed(2),
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
