import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/tab_state_provider.dart';
import 'package:quizmix_frontend/views/modals/advanced_search_modal.dart';
import 'package:quizmix_frontend/views/modals/view_question_modal.dart';
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
    final modalState = ref.watch(modalStateProvider);

    return Stack(
      children: [
        Scaffold(
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
        ),
        if (modalState == ModalState.advancedSearch) ...[
          Container(
            color: AppColors.fourthColor.withOpacity(0.8),
            child: const AdvancedSearhModal(),
          ),
        ] else if (modalState == ModalState.viewQuestion) ...[
          Container(
            color: AppColors.fourthColor.withOpacity(0.8),
            child: const ViewQuestionModal(),
          ),
        ] else if (modalState == ModalState.preparingQuiz) ...[
          Scaffold(
            body: Container(
              color: AppColors.mainColor,
              child: const Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 48.0,
                        width: 48.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 6.0,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        "Preparing Quiz...",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ]
      ],
    );
  }
}
