import 'package:flutter/material.dart';
import 'package:quizmix_frontend/views/screens/Reviewer/UploadedQuestionsScreen.dart';
import 'package:quizmix_frontend/views/widgets/TinySolidButton.dart';

class UploadedQuestionItemContainer extends StatelessWidget {
  final QuestionDetails questionDetails;
  final int index;

  const UploadedQuestionItemContainer({
    super.key,
    required this.questionDetails,
    required this.index,
  });

  Color getCategoryColor(String category) {
    switch (category) {
      case 'Algorithms and Programming':
        return const Color(0xFF9854B2);
      case 'Computer Components and Hardware':
        return const Color(0xFFCF4321);
      case 'System Components':
        return const Color(0xFFC92D5C);
      case 'Software':
        return const Color(0xFF0D2916);
      case 'Development Technology and Management':
        return const Color(0xFF3371E4);
      case 'Database':
        return const Color(0xFF75A768);
      case 'Network':
        return const Color(0xFF8768A7);
      case 'Security':
        return const Color(0xFF223160);
      case 'System Audit, Strategy and Planning':
        return const Color(0xFF678026);
      case 'Business, Corporate & Legal Affairs':
        return const Color(0xFF282680);
      default:
        // Return a random color for unknown categories
        return Colors.primaries[index % Colors.primaries.length];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: null,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF03045E)),
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
                buttonColor: const Color(0xFF03045E),
                onPressed: () {
                  // Handle edit button press
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
                  questionDetails.questionText,
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
                child: Image.asset(
                  questionDetails.imagePath,
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
                const Text(
                  'Answer: ',
                  style: TextStyle(fontSize: 20),
                ),
                Text(questionDetails.answer,
                    style: const TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
