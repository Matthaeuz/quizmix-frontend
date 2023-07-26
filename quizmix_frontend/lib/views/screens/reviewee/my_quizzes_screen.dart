import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_dashboard/my_quiz_item.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_dashboard/reviewee_dashboard.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_dashboard/my_quizzes_list.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_dashboard/my_reviewees_list.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/widgets/search_input.dart';

class MyQuizzesScreen extends ConsumerWidget {
  MyQuizzesScreen({Key? key}) : super(key: key);

  final List<String> titles = [
    'Algorithms and Programming',
    'Data Structures',
    'Object-Oriented Programming',
    'Algorithms and Programming',
    'Data Structures',
    'Object-Oriented Programming',
    'Algorithms and Programming',
    'Data Structures',
    'Object-Oriented Programming',
    'Algorithms and Programming',
    'Data Structures',
    'Object-Oriented Programming',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Row(
        children: [
          // Left Side - Dashboard
          const RevieweeDashboardWidget(
            selectedOption: 'My Quizzes',
          ),
          // Right Side - List of Quizzes
          Expanded(
            flex: 8,
            child: Container(
              color: AppColors.fifthColor,
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Input
                  SearchInput(
                    onChanged: (value) {
                      // Handle search input changes
                    },
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: titles.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            MyQuizItem(title: titles[index]),
                            const SizedBox(height: 25),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
