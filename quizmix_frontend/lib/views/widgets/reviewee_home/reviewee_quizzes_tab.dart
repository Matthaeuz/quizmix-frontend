import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/providers/quizzes/reviewee_quizzes_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_quizzes_tab/reviewee_quiz_item.dart';
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
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: AppColors.mainColor,
      child: quizzes.when(
        data: (data) {
          final allQuizzesLen =
              ref.read(revieweeQuizzesProvider.notifier).allQuizzes.length;
          if (data.isEmpty && allQuizzesLen == 0) {
            return const Center(
              child: SingleChildScrollView(
                child: EmptyDataPlaceholder(
                  message: "You currently have no quizzes",
                ),
              ),
            );
          }

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                            0, screenHeight > 160 ? 100 : 0, 0, 0),
                        child: Wrap(
                          spacing: 24.0,
                          runSpacing: 24.0,
                          children: [
                            for (var index = 0;
                                index < data.length;
                                index++) ...[
                              RevieweeQuizItem(quiz: data[index]),
                            ]
                          ],
                        ),
                      ),
                    ),
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
              // Search Input
              screenHeight > 160
                  ? Container(
                      padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
                      color: AppColors.mainColor.withOpacity(0.5),
                      child: SizedBox(
                        width: 480,
                        child: TextField(
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: AppColors.white,
                            hintText: 'Search Quizzes',
                            prefixIcon: Icon(
                              Icons.search,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 8),
                          ),
                          onChanged: (value) {
                            ref
                                .read(revieweeQuizzesProvider.notifier)
                                .searchQuizzes(value);
                          },
                        ),
                      ),
                    )
                  : const SizedBox(),
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
        error: (err, stack) => const Center(
          child: SingleChildScrollView(
            child: EmptyDataPlaceholder(
              message: "Please try again later",
            ),
          ),
        ),
      ),
    );
  }
}
