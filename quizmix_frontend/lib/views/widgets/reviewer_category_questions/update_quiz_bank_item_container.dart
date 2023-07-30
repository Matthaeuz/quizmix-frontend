import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/questions/current_edited_question_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewer/edit_question_screen.dart';
import 'package:quizmix_frontend/views/widgets/tiny_solid_button.dart';

class UpdateQuizBankItemContainer extends ConsumerWidget {
  final Question questionDetails;
  final int index;
  final bool showCategory;

  const UpdateQuizBankItemContainer({
    super.key,
    required this.questionDetails,
    required this.index,
    this.showCategory = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: null,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.mainColor),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question ${index + 1}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              // Category Container
              if (showCategory)
                Container(
                  decoration: BoxDecoration(
                    color: getCategoryColor(questionDetails.category),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    questionDetails.category,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              const Spacer(),
              TinySolidButton(
                text: 'Edit',
                buttonColor: AppColors.mainColor,
                onPressed: () {
                  ref
                      .read(currentEditedQuestionProvider.notifier)
                      .updateCurrentEditedQuestion(questionDetails);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditQuestionScreen()));
                },
                icon: Icons.edit,
              ),
              const SizedBox(width: 10),
              TinySolidButton(
                text: 'Delete',
                buttonColor: Colors.red,
                onPressed: () {
                  // Handle delete button press
                },
                icon: Icons.delete,
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  questionDetails.question,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                  questionDetails.image!,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Choices: ',
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  children: [
                    Text(questionDetails.choices[0],
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(questionDetails.choices[1],
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(questionDetails.choices[2],
                        style: const TextStyle(fontSize: 16)),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(questionDetails.choices[3],
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                Column(
                  children: [
                    const Text(
                      'Answer:',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(questionDetails.answer,
                        style: const TextStyle(fontSize: 16)),
                  ],
                ),
                if (questionDetails.solution != null &&
                    questionDetails.solution!.isNotEmpty)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        'Explanation:',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        questionDetails.solution!,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
