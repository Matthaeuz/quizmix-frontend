import 'package:flutter/material.dart';
import 'package:quizmix_frontend/models/QuestionDetails.dart';

class ViewQuestionBankCard extends StatelessWidget {
  final QuestionDetails questionDetails;
  final int index;

  const ViewQuestionBankCard({
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
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xFF03045E),
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
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: getCategoryColor(questionDetails.category),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  questionDetails.category,
                  style: const TextStyle(
                    color: Colors.white,
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
            child: Image.asset(
              questionDetails.imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
