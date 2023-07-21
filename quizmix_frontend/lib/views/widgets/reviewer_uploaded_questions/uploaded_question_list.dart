import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/providers/questions/uploaded_questions_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_uploaded_questions/uploaded_question_item_container.dart';

class UploadedQuestionList extends ConsumerWidget {
  const UploadedQuestionList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(uploadedQuestionsProvider);
    
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        shrinkWrap: true,
        itemCount: questions!.length,
        itemBuilder: (BuildContext context, int index) {
          final details = questions[index];
          return UploadedQuestionItemContainer(
            questionDetails: details,
            index: index,
          );
        },
      ),
    );
  }
}
