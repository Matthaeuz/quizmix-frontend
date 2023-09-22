import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/tab_state_provider.dart';
import 'package:quizmix_frontend/views/modals/add_question_pdf_modal.dart';
import 'package:quizmix_frontend/views/modals/advanced_search_modal.dart';
import 'package:quizmix_frontend/views/modals/create_edit_question_modal.dart';
import 'package:quizmix_frontend/views/modals/retrain_model_modal.dart';
import 'package:quizmix_frontend/views/modals/view_question_modal.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_home/reviewer_dashboard_tab.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_home/reviewer_question_bank_tab.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_home/reviewer_quizzes_tab.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_home/reviewer_reviewees_tab.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_home/reviewer_tabs.dart';

class ReviewerHomeScreen extends ConsumerStatefulWidget {
  const ReviewerHomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ReviewerHomeScreen> createState() => _ReviewerHomeScreenState();
}

class _ReviewerHomeScreenState extends ConsumerState<ReviewerHomeScreen> {
  Widget getWidgetFromTabState(TabState tabState) {
    if (tabState == TabState.reviewerDashboard) {
      return const ReviewerDashboardTab();
    } else if (tabState == TabState.reviewerQuizzes) {
      return const ReviewerQuizzesTab();
    } else if (tabState == TabState.reviewerReviewees) {
      return const ReviewerRevieweesTab();
    } else if (tabState == TabState.reviewerQuestionBank) {
      return const ReviewerQuestionBankTab();
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
                child: ReviewerTabs(),
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
        ] else if (modalState == ModalState.createEditQuestion) ...[
          Container(
            color: AppColors.fourthColor.withOpacity(0.8),
            child: const CreateEditQuestionModal(),
          ),
        ] else if (modalState == ModalState.uploadPDFs) ...[
          Container(
            color: AppColors.fourthColor.withOpacity(0.8),
            child: const AddQuestionPdfModal(),
          ),
        ] else if (modalState == ModalState.retrainModel) ...[
          Container(
            color: AppColors.fourthColor.withOpacity(0.8),
            child: const RetrainModelModal(),
          ),
        ]
      ],
    );
  }
}
