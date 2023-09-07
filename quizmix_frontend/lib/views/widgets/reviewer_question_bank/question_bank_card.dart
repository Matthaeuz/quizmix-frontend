import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/questions/current_question_provider.dart';

class QuestionBankCard extends ConsumerWidget {
  final Question questionDetails;

  const QuestionBankCard({
    Key? key,
    required this.questionDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref
            .read(currentQuestionProvider.notifier)
            .updateCurrentQuestion(questionDetails);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: AppColors.mainColor,
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'Category:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color: getCategoryColor(questionDetails.category.name),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      questionDetails.category.name,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF9854B2),
                ),
              ),
              child: Image.network(
                questionDetails.image!,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
