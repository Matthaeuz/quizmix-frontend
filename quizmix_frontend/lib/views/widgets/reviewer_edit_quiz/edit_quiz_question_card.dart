import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/questions/current_question_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/views/widgets/responsive_tiny_solid_button.dart';

enum EditQuizAction { add, remove }

class EditQuizQuestionCard extends ConsumerWidget {
  final Question questionDetails;
  final EditQuizAction action;
  final void Function() onClick;
  final bool condition;

  const EditQuizQuestionCard({
    Key? key,
    required this.questionDetails,
    required this.action,
    required this.onClick,
    required this.condition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () {
          ref
              .read(currentQuestionProvider.notifier)
              .updateCurrentQuestion(questionDetails);
          ref
              .read(modalStateProvider.notifier)
              .updateModalState(ModalState.viewQuestion);
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Question No. ${questionDetails.id}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Category: ${questionDetails.category.name}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ResponsiveTinySolidButton(
                    text: action == EditQuizAction.add ? "Add" : "Remove",
                    icon: action == EditQuizAction.add
                        ? Icons.add
                        : Icons.remove,
                    buttonColor: action == EditQuizAction.add
                        ? AppColors.mainColor
                        : AppColors.red,
                    onPressed: onClick,
                    condition: condition,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                questionDetails.question,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
