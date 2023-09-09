import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/questions/current_question_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';

class QuestionBankItem extends ConsumerWidget {
  final Question question;

  const QuestionBankItem({super.key, required this.question});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref
            .read(currentQuestionProvider.notifier)
            .updateCurrentQuestion(question);
        ref
            .read(modalStateProvider.notifier)
            .updateModalState(ModalState.viewQuestion);
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: 352,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12), // Add border radius of 5
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
              Text(
                "Question No. ${question.id}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Category: ${question.category.name}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                question.question,
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
