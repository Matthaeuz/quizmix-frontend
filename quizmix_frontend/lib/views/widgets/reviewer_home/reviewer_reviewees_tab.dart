import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/reviewees/unassigned_reviewees_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewer/add_reviewee_screen.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_list_card.dart';
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

class ReviewerRevieweesTab extends ConsumerStatefulWidget {
  const ReviewerRevieweesTab({Key? key}) : super(key: key);

  @override
  ConsumerState<ReviewerRevieweesTab> createState() =>
      _ReviewerRevieweesTabState();
}

class _ReviewerRevieweesTabState extends ConsumerState<ReviewerRevieweesTab> {
  @override
  Widget build(BuildContext context) {
    final unfilteredReviewees = ref.watch(unassignedRevieweesProvider);

    final searchTerm = ref.watch(searchTermProvider);

    final filteredReviewees = unfilteredReviewees.when(
      data: (reviewees) {
        return reviewees.where((reviewee) {
          final fullName = reviewee.fullName.toLowerCase();
          return fullName.contains(searchTerm.toLowerCase());
        }).toList();
      },
      loading: () => [],
      error: (_, __) => [],
    );

    return Container(
      color: AppColors.mainColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
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
                        ref
                            .read(searchTermProvider.notifier)
                            .setSearchTerm(value);
                      },
                    ),
                  ),
                ),
                // Add Reviewee Button - On the very right
                SolidButton(
                  text: 'Add Reviewee',
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddRevieweeScreen()));
                  },
                  icon: const Icon(Icons.person_add),
                ),
              ],
            ),
            // List
            filteredReviewees.isEmpty
                ? const Expanded(
                    child: EmptyDataPlaceholder(
                        message:
                            "There are currently no unassigned reviewees."))
                : Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 25),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 25,
                          mainAxisSpacing: 25,
                          mainAxisExtent: 125,
                        ),
                        itemCount: filteredReviewees.length,
                        itemBuilder: (context, index) {
                          return RevieweeListCard(
                            revieweeDetails: filteredReviewees[index],
                          );
                        },
                      ),
                    ),
                  ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
