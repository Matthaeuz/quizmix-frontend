import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/quizzes/reviewer_quizzes_provider.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_dashboard/quiz_detail_card.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_dashboard/reviewer_dashboard.dart';
import 'package:quizmix_frontend/views/widgets/search_input.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class QuizzesListScreen extends ConsumerWidget {
  const QuizzesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzes = ref.watch(reviewerQuizzesProvider);

    return Scaffold(
      body: Row(
        children: [
          // Left Side - Dashboard
          const ReviewerDashboardWidget(
            selectedOption: 'Quizzes',
          ),
          // Right Side - Background Color
          Expanded(
            flex: 8,
            child: Container(
              color: AppColors.fifthColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        // Search Input - On the very left
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: SearchInput(
                              onChanged: (value) {
                                // Handle search input changes
                              },
                            ),
                          ),
                        ),
                        // Add Reviewee Button - On the very right
                        SolidButton(
                          text: 'Create Quiz',
                          onPressed: () {},
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // List
                    quizzes.when(
                      data: (quizzes) => quizzes.isEmpty
                          ? const Expanded(
                              child: EmptyDataPlaceholder(
                                  message: "There are currently no quizzes."))
                          : Expanded(
                              child: SingleChildScrollView(
                                child: Wrap(
                                  spacing: 24,
                                  runSpacing: 24,
                                  children: [
                                    for (int i = 0;
                                        i < quizzes.length;
                                        i++) ...[
                                      QuizDetailCard(quiz: quizzes[i]),
                                    ]
                                  ],
                                ),
                              ),
                            ),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (err, stack) => Text('Error Found: $err'),
                    ),
                    const SizedBox(height: 25),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
