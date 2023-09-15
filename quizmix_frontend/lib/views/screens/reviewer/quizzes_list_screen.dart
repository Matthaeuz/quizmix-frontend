import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/quizzes/reviewer_quizzes_provider.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_dashboard/quiz_detail_card.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_dashboard/reviewer_dashboard.dart';
import 'package:quizmix_frontend/views/widgets/search_input.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class SearchTermNotifier extends StateNotifier<String> {
  SearchTermNotifier() : super('');

  void setSearchTerm(String term) {
    state = term;
  }
}

final searchTermProvider =
    StateNotifierProvider<SearchTermNotifier, String>((ref) {
  return SearchTermNotifier();
});

class QuizzesListScreen extends ConsumerWidget {
  const QuizzesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzes = ref.watch(reviewerQuizzesProvider);
    final searchTerm = ref.watch(searchTermProvider);

    List<Widget> filteredQuizzes = quizzes.when(
      data: (quizzes) {
        if (searchTerm.isEmpty) {
          return quizzes.map((quiz) => QuizDetailCard(quiz: quiz)).toList();
        } else {
          return quizzes
              .where((quiz) =>
                  quiz.title.toLowerCase().contains(searchTerm.toLowerCase()))
              .map((quiz) => QuizDetailCard(quiz: quiz))
              .toList();
        }
      },
      loading: () => const [Center(child: CircularProgressIndicator())],
      error: (err, stack) => [Text('Error Found: $err')],
    );

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
                                ref.read(searchTermProvider.notifier).setSearchTerm(value);
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
                    filteredQuizzes.isEmpty
                        ? const Expanded(
                            child: EmptyDataPlaceholder(
                                message: "There are currently no quizzes."))
                        : Expanded(
                            child: SingleChildScrollView(
                              child: Wrap(
                                spacing: 24,
                                runSpacing: 24,
                                children: filteredQuizzes,
                              ),
                            ),
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
