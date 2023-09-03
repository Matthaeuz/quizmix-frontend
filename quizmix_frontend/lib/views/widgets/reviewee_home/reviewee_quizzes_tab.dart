import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/providers/quizzes/reviewee_quizzes_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_dashboard/my_quiz_item.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';

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
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Input
          // SearchInput(
          //   onChanged: (value) {
          //     // Handle search input changes
          //   },
          // ),
          // const SizedBox(height: 24),
          Expanded(
            child: Consumer(
              builder: (context, watch, child) {
                return quizzes.when(
                  data: (data) {
                    if (data.isEmpty) {
                      return const EmptyDataPlaceholder(
                        message: "You currently have no quizzes.",
                      );
                    }
                    return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        final quiz = data[index];
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                          child: MyQuizItem(quiz: quiz),
                        );
                      },
                    );
                  },
                  loading: () => const Center(
                    child: SizedBox(
                      width: 50.0,
                      height: 50.0,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  error: (err, stack) => Text('Error: $err'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
