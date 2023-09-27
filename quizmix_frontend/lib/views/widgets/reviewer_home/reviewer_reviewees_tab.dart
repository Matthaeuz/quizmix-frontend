import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/reviewees/current_viewed_reviewee_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewer_reviewees_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewer/add_reviewee_screen.dart';
import 'package:quizmix_frontend/views/screens/view_reviewee_profile_screen.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/responsive_solid_button.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_reviewees_tab/reviewer_reviewee_item.dart';

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

class ReviewerRevieweesTab extends ConsumerStatefulWidget {
  const ReviewerRevieweesTab({Key? key}) : super(key: key);

  @override
  ConsumerState<ReviewerRevieweesTab> createState() =>
      _ReviewerRevieweesTabState();
}

class _ReviewerRevieweesTabState extends ConsumerState<ReviewerRevieweesTab> {
  @override
  Widget build(BuildContext context) {
    final reviewees = ref.watch(reviewerRevieweesProvider);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: AppColors.mainColor,
      child: reviewees.when(
        data: (data) {
          final allRevieweesLen =
              ref.read(reviewerRevieweesProvider.notifier).allReviewees.length;
          return Stack(
            children: [
              data.isEmpty && allRevieweesLen == 0
                  ? const Center(
                      child: SingleChildScrollView(
                        child: EmptyDataPlaceholder(
                          message: "You currently have no reviewees",
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
                                    ReviewerRevieweeItem(
                                      reviewee: data[index],
                                      onClick: () {
                                        ref
                                            .read(currentViewedRevieweeProvider
                                                .notifier)
                                            .updateCurrentReviewee(data[index]);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const ViewRevieweeProfileScreen(),
                                          ),
                                        );
                                      },
                                    ),
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
                            flex: screenWidth > 940 ? 0 : 1,
                            child: SizedBox(
                              width: screenWidth > 940 ? 480 : null,
                              child: TextField(
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.white,
                                  hintText: 'Search Reviewees',
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
                                      .read(reviewerRevieweesProvider.notifier)
                                      .searchReviewees(value);
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                            child: ResponsiveSolidButton(
                              text: "Assign/Unassign",
                              icon: const Icon(Icons.edit),
                              elevation: 8.0,
                              condition: screenWidth > 660,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const AddRevieweeScreen()));
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
