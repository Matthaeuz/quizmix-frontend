import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/providers/ui/tab_state_provider.dart';
import 'package:quizmix_frontend/views/widgets/profile_area.dart';
import 'package:quizmix_frontend/views/widgets/sign_out_area.dart';
import 'package:quizmix_frontend/views/widgets/tab_item.dart';

class TabsWidget extends ConsumerWidget {
  const TabsWidget({Key? key}) : super(key: key);

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
              if (tabState != TabState.revieweeQuizzes) {
                ref
                    .read(tabStateProvider.notifier)
                    .updateTabState(TabState.revieweeQuizzes);
              }
            },
            text: "My Quizzes",
            icon: Icons.assignment,
            isSelected: tabState == TabState.revieweeQuizzes,
          ),
          TabItem(
            onTap: () {
              if (tabState != TabState.revieweeMixes) {
                ref
                    .read(tabStateProvider.notifier)
                    .updateTabState(TabState.revieweeMixes);
              }
            },
            text: "My Mixes",
            icon: Icons.shuffle,
            isSelected: tabState == TabState.revieweeMixes,
          ),
          TabItem(
            onTap: () {
              if (tabState != TabState.revieweeQuestionBank) {
                ref
                    .read(tabStateProvider.notifier)
                    .updateTabState(TabState.revieweeQuestionBank);
              }
            },
            text: "Question Bank",
            icon: Icons.question_answer,
            isSelected: tabState == TabState.revieweeQuestionBank,
          ),
          SizedBox(height: screenHeight - 360 > 0 ? screenHeight - 360 : 0),
          const SignOutArea(),
        ],
      ),
    );
  }
}
