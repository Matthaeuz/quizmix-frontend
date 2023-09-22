import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/questions/current_question_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';

class CreateEditQuestionModal extends ConsumerStatefulWidget {
  const CreateEditQuestionModal({Key? key}) : super(key: key);

  @override
  CreateEditQuestionModalState createState() => CreateEditQuestionModalState();
}

class CreateEditQuestionModalState
    extends ConsumerState<CreateEditQuestionModal> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final question = ref.watch(currentQuestionProvider);

    return Scaffold(
      appBar: null,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: IntrinsicHeight(
              child: Container(
                width: 452,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          question == null
                              ? ref
                                  .read(modalStateProvider.notifier)
                                  .updateModalState(ModalState.none)
                              : ref
                                  .read(modalStateProvider.notifier)
                                  .updateModalState(ModalState.viewQuestion);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,
                          foregroundColor: AppColors.mainColor,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.arrow_back,
                              size: 16.0,
                              color: AppColors.mainColor,
                            ),
                            Text(question == null
                                ? "Back to Question Bank"
                                : "Back to Question"),
                          ],
                        ),
                      ),
                      Text(
                        question == null ? "Create Question" : "Edit Question",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
