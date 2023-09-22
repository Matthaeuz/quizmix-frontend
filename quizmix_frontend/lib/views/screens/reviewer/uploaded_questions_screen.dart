import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/questions/uploaded_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/views/modals/create_edit_question_modal.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_uploaded_questions/uploaded_question_item_container.dart';

class UploadedQuestionsScreen extends ConsumerWidget {
  const UploadedQuestionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modalState = ref.watch(modalStateProvider);
    final questions = ref.watch(uploadedQuestionsProvider);
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          questions.isNotEmpty
              ? ListView.builder(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  shrinkWrap: true,
                  itemCount: questions.length,
                  itemBuilder: (BuildContext context, int index) {
                    final details = questions[index];
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: index == 0 ? 120 : 0,
                          bottom: 24,
                        ),
                        child: UploadedQuestionItemContainer(
                          currentQuestion: details,
                          index: index,
                        ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: SingleChildScrollView(
                    child: EmptyDataPlaceholder(
                      message: "There are no questions to show",
                      color: AppColors.white,
                    ),
                  ),
                ),
          screenHeight > 180
              ? Container(
                  width: 800,
                  padding: const EdgeInsets.all(24),
                  color: AppColors.mainColor.withOpacity(0.9),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          ref
                              .read(modalStateProvider.notifier)
                              .updateModalState(ModalState.none);
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,
                          foregroundColor: AppColors.white,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              size: 16.0,
                              color: AppColors.white,
                            ),
                            Text("Back to Question Bank"),
                          ],
                        ),
                      ),
                      const Text(
                        "Uploaded Questions",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
          if (modalState == ModalState.createEditQuestion) ...[
            Container(
              color: AppColors.fourthColor.withOpacity(0.8),
              child: const CreateEditQuestionModal(),
            ),
          ]
        ],
      ),
    );
  }
}
