import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart'; // Import the widget
import 'package:quizmix_frontend/state/providers/questions/category_questions_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_category_questions/update_quiz_bank_item_container.dart';

class CategoryQuestionsList extends ConsumerWidget {
  final String title;
  const CategoryQuestionsList({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: change to category ID implementation
    final questions = ref.watch(categoryQuestionsProvider(1));

    return questions.when(
      data: (questions) {
        if (questions.isEmpty) {
          return const Expanded(
            child: EmptyDataPlaceholder(
              message: "There are currently no questions for this category.",
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(12.0),
          shrinkWrap: true,
          itemCount: questions.length,
          itemBuilder: (BuildContext context, int index) {
            final details = questions[index];
            return UpdateQuizBankItemContainer(
              questionDetails: details,
              index: index,
              showCategory: false,
            );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }
}
