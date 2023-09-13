import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/models/users/assign_reviewee_details.dart';
import 'package:quizmix_frontend/state/models/users/user.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewer_reviewees_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_reviewee_list/AddRevieweeCard.dart';
import 'package:quizmix_frontend/views/widgets/search_input.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';
import 'package:quizmix_frontend/state/providers/reviewees/unassigned_reviewees_provider.dart'; // Import the provider

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

class AddRevieweeScreen extends ConsumerStatefulWidget {
  const AddRevieweeScreen({Key? key}) : super(key: key);

  @override
  _AddRevieweeScreenState createState() => _AddRevieweeScreenState();
}

class _AddRevieweeScreenState extends ConsumerState<AddRevieweeScreen> {
  List<bool> isCheckedList = [];
  List<User> selectedReviewees = [];
  Map<int, bool> isCheckedMap = {}; // Use a Map to store selected state

  void printSelectedReviewees() {
    for (var reviewee in selectedReviewees) {
      debugPrint(reviewee.fullName);
    }
  }

  Future<void> addSelectedReviewees() async {
    final reviewees = ref.read(unassignedRevieweesProvider);
    final reviewer = ref.read(userProvider);
    final client = ref.read(restClientProvider);
    final token = ref.read(authTokenProvider).accessToken;

    selectedReviewees.clear();
    await reviewees.when(
      data: (reviewees) async {
        for (int i = 0; i < reviewees.length; i++) {
          final reviewee = reviewees[i];
          final revieweeId = reviewee.id;

          // Check if the reviewee with this ID is selected in isCheckedMap
          if (isCheckedMap.containsKey(revieweeId) &&
              isCheckedMap[revieweeId] == true) {
            selectedReviewees.add(reviewee);

            final details = AssignRevieweeDetails(
              revieweeId: revieweeId,
              reviewerId: reviewer.id,
            );
            await client.assignReviewee(token, details);
          }
        }

        // inform providers of change
        ref.read(reviewerRevieweesProvider.notifier).fetchReviewerReviewees();
        ref
            .read(unassignedRevieweesProvider.notifier)
            .fetchUnassignedReviewees()
            .then((value) {
          Navigator.pop(context);
        });

        // printSelectedReviewees();
      },
      loading: () {},
      error: (error, stackTrace) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final revieweesFuture = ref.watch(unassignedRevieweesProvider);

    // Step 1: Read the current search term from the state
    final searchTerm = ref.watch(searchTermProvider);

    // Step 2: Filter the reviewees based on the search term
    final filteredReviewees = revieweesFuture.when(
      data: (reviewees) {
        return reviewees.where((reviewee) {
          final fullName = reviewee.fullName.toLowerCase();
          return fullName.contains(searchTerm.toLowerCase());
        }).toList();
      },
      loading: () => [], // Return an empty list during loading
      error: (_, __) => [], // Return an empty list on error
    );

    // Initialize isCheckedList with the same number of elements as filteredReviewees
    if (isCheckedList.length != filteredReviewees.length) {
      isCheckedList = List.generate(filteredReviewees.length, (index) => false);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Search Reviewee',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SearchInput(
                      onChanged: (value) {
                        // Step 3: Update the search term in the state
                        ref
                            .read(searchTermProvider.notifier)
                            .setSearchTerm(value);
                      },
                    ),
                  ),
                ),
                SolidButton(
                  text: 'Add Selected',
                  onPressed: () {
                    addSelectedReviewees();
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: filteredReviewees.isEmpty
                  ? const EmptyDataPlaceholder(
                      message: "No unassigned reviewees found.",
                    )
                  : ListView.separated(
                      itemCount: filteredReviewees.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 25),
                      itemBuilder: (context, index) {
                        final reviewee = filteredReviewees[index];

                        return AddRevieweeCard(
                          reviewee: reviewee,
                          isSelected: isCheckedMap.containsKey(reviewee.id) &&
                              isCheckedMap[reviewee.id] == true,
                          onCheckboxChanged: (value) {
                            setState(() {
                              isCheckedMap[reviewee.id] =
                                  value; // Update the Map with the selected state
                            });
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
