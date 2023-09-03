import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/providers/ui/tab_state_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_home/reviewee_mixes_tab.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_home/reviewee_question_bank_tab.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_home/reviewee_quizzes_tab.dart';
import 'package:quizmix_frontend/views/widgets/tabs.dart';

class RevieweeHomeScreen extends ConsumerStatefulWidget {
  const RevieweeHomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RevieweeHomeScreen> createState() => _RevieweeHomeScreenState();
}

class _RevieweeHomeScreenState extends ConsumerState<RevieweeHomeScreen> {
  Widget getWidgetFromTabState(TabState tabState) {
    if (tabState == TabState.revieweeQuizzes) {
      return const RevieweeQuizzesTab();
    } else if (tabState == TabState.revieweeMixes) {
      return const RevieweeMixesTab();
    } else if (tabState == TabState.revieweeQuestionBank) {
      return const RevieweeQuestionBankTab();
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final tabState = ref.watch(tabStateProvider);

    return Scaffold(
      body: Row(
        children: [
          const Expanded(
            flex: 2,
            child: TabsWidget(),
          ),
          Expanded(
            flex: 8,
            child: getWidgetFromTabState(tabState),
          ),
        ],
      ),
    );
  }
}
