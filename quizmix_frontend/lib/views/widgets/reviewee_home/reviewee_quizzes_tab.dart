import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/providers/quizzes/reviewee_quizzes_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_quizzes_tab/reviewee_quiz_item.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/search_input.dart';

class RevieweeQuizzesTab extends ConsumerStatefulWidget {
  const RevieweeQuizzesTab({Key? key}) : super(key: key);

  @override
  ConsumerState<RevieweeQuizzesTab> createState() => _RevieweeQuizzesTabState();
}

class _RevieweeQuizzesTabState extends ConsumerState<RevieweeQuizzesTab> {
  @override
  Widget build(BuildContext context) {
    final quizzes = ref.watch(revieweeQuizzesProvider);

    return Container(
      color: AppColors.mainColor,
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
      child: quizzes.when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(
              child: SingleChildScrollView(
                child: EmptyDataPlaceholder(
                  message: "You currently have no quizzes",
                ),
              ),
            );
          }
          //this widget
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    // Search Input
                    SearchInput(
                      onChanged: (value) {
                        // Handle search input changes
                      },
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 24.0,
                      runSpacing: 24.0,
                      children: [
                        for (var index = 0; index < data.length; index++) ...[
                          RevieweeQuizItem(quiz: data[index]),
                        ]
                      ],
                    ),
                  ],
                ),
              ),
              const SliverFillRemaining(
                hasScrollBody: false,
                child: SizedBox(),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: SizedBox(
            width: 48.0,
            height: 48.0,
            child: CircularProgressIndicator(color: AppColors.white),
          ),
        ),
        error: (err, stack) => Center(
          child: SingleChildScrollView(
            child: EmptyDataPlaceholder(
              message: "Error: $err",
            ),
          ),
        ),
      ),
    );
  }
}
