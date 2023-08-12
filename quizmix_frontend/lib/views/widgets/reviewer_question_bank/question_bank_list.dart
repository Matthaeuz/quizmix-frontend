import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart'; // Import the widget
import 'package:quizmix_frontend/state/providers/questions/question_bank_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_question_bank/question_bank_card.dart';

class QuestionBankList extends ConsumerWidget {
  const QuestionBankList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questions = ref.watch(questionBankProvider);

    return questions.when(
      data: (questions) {
        if (questions.isEmpty) {
          return const EmptyDataPlaceholder(
            message: "There are currently no questions in the bank.",
            iconSize: 150,
            fontSize: 18,
          );
        }
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: questions.length,
          itemBuilder: (context, index) {
            return QuestionBankCard(
              questionDetails: questions[index],
            );
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
