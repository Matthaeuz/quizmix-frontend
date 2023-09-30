import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/quizzes/reviewer_quizzes_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/responsive_solid_button.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_quizzes_tab/reviewer_quiz_item.dart';

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

class ReviewerQuizzesTab extends ConsumerStatefulWidget {
  const ReviewerQuizzesTab({Key? key}) : super(key: key);

  @override
  ConsumerState<ReviewerQuizzesTab> createState() => _ReviewerQuizzesTabState();
}

class _ReviewerQuizzesTabState extends ConsumerState<ReviewerQuizzesTab> {
  @override
  Widget build(BuildContext context) {
    final quizzes = ref.watch(reviewerQuizzesProvider);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: AppColors.mainColor,
      child: quizzes.when(
        data: (data) {
          final allQuizzesLen =
              ref.read(reviewerQuizzesProvider.notifier).allQuizzes.length;
          return Stack(
            children: [
              data.isEmpty && allQuizzesLen == 0
                  ? const Center(
                      child: SingleChildScrollView(
                        child: EmptyDataPlaceholder(
                          message: "You currently have no quizzes",
                        ),
                      ),
                    )
                  : Padding(
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
                                    ReviewerQuizItem(quiz: data[index]),
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
              // Search Input & Add Mix
              screenHeight > 160
                  ? Container(
                      padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
                      color: AppColors.mainColor.withOpacity(0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: screenWidth > 880 &&
                                    data.isNotEmpty &&
                                    allQuizzesLen > 0
                                ? 0
                                : 1,
                            child: data.isEmpty && allQuizzesLen == 0
                                ? const SizedBox()
                                : SizedBox(
                                    width: screenWidth > 860 ? 480 : null,
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
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 8),
                                      ),
                                      onChanged: (value) {
                                        ref
                                            .read(reviewerQuizzesProvider
                                                .notifier)
                                            .searchQuizzes(value);
                                      },
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                            child: ResponsiveSolidButton(
                              text: "Create Quiz",
                              icon: const Icon(Icons.add),
                              elevation: 8.0,
                              condition: screenWidth > 660,
                              onPressed: () {
                                ref
                                    .read(modalStateProvider.notifier)
                                    .updateModalState(ModalState.createQuiz);
                              },
                            ),
                          ),
                        ],
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
