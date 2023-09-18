import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/providers/ui/tab_state_provider.dart';
import 'package:quizmix_frontend/views/widgets/profile_area.dart';
import 'package:quizmix_frontend/views/widgets/sign_out_area.dart';
import 'package:quizmix_frontend/views/widgets/tab_item.dart';

class ReviewerTabs extends ConsumerWidget {
  const ReviewerTabs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabState = ref.watch(tabStateProvider);
    double screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        children: [
          const ProfileArea(),
          TabItem(
            onTap: () {
              if (tabState != TabState.reviewerDashboard) {
                ref
                    .read(tabStateProvider.notifier)
                    .updateTabState(TabState.reviewerDashboard);
              }
            },
            text: "Dashboard",
            icon: Icons.dashboard,
            isSelected: tabState == TabState.reviewerDashboard,
          ),
          TabItem(
            onTap: () {
              if (tabState != TabState.reviewerQuizzes) {
                ref
                    .read(tabStateProvider.notifier)
                    .updateTabState(TabState.reviewerQuizzes);
              }
            },
            text: "Quizzes",
            icon: Icons.quiz,
            isSelected: tabState == TabState.reviewerQuizzes,
          ),
          TabItem(
            onTap: () {
              if (tabState != TabState.reviewerReviewees) {
                ref
                    .read(tabStateProvider.notifier)
                    .updateTabState(TabState.reviewerReviewees);
              }
            },
            text: "Reviewees",
            icon: Icons.person,
            isSelected: tabState == TabState.reviewerReviewees,
          ),
          TabItem(
            onTap: () {
              if (tabState != TabState.reviewerQuestionBank) {
                ref
                    .read(tabStateProvider.notifier)
                    .updateTabState(TabState.reviewerQuestionBank);
              }
            },
            text: "Question Bank",
            icon: Icons.question_answer,
            isSelected: tabState == TabState.reviewerQuestionBank,
          ),
          SizedBox(height: screenHeight - 420 > 0 ? screenHeight - 420 : 0),
          const SignOutArea(),
        ],
      ),
    );
  }
}
