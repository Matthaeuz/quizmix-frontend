import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewer_reviewees_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewers/reviewer_details_provider.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_reviewee_list/AddRevieweeCard.dart';
import 'package:quizmix_frontend/views/widgets/search_input.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';
import 'package:quizmix_frontend/state/models/reviewees/reviewee.dart'; // Assuming the Reviewee model is defined in this import
// import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
// import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/unassigned_reviewees_provider.dart'; // Import the provider

class AddRevieweeScreen extends ConsumerStatefulWidget {
  const AddRevieweeScreen({Key? key}) : super(key: key);

  @override
  _AddRevieweeScreenState createState() => _AddRevieweeScreenState();
}

class _AddRevieweeScreenState extends ConsumerState<AddRevieweeScreen> {
  List<bool> isCheckedList = [];
  List<Reviewee> selectedReviewees = [];

  void printSelectedReviewees() {
    for (var reviewee in selectedReviewees) {
      debugPrint(reviewee.user.fullName);
    }
  }

  Future<void> addSelectedReviewees() async {
    final reviewees = ref.read(unassignedRevieweesProvider);
    final reviewerId = ref.read(reviewerProvider).id;
    final client = ref.read(restClientProvider);
    final token = ref.read(authTokenProvider).accessToken;

    selectedReviewees.clear();
    await reviewees.when(
      data: (reviewees) async {
        for (int i = 0; i < isCheckedList.length; i++) {
          if (isCheckedList[i]) {
            final reviewee = reviewees[i];
            selectedReviewees.add(reviewee);

            final newDetails = {
              "belongs_to": reviewerId,
            };
            await client.updateReviewee(token, reviewee.id, newDetails);
          }
        }

        // inform providers of change
        ref.read(reviewerRevieweesProvider.notifier).fetchReviewerReviewees();
        ref
            .read(unassignedRevieweesProvider.notifier)
            .fetchUnassignedReviewees();
        Navigator.pop(context);
        // printSelectedReviewees();
      },
      loading: () {},
      error: (error, stackTrace) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    final revieweesFuture = ref.watch(unassignedRevieweesProvider);

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
                        // Handle search input changes
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
              child: revieweesFuture.when(
                data: (reviewees) {
                  if (reviewees.isEmpty) {
                    return const EmptyDataPlaceholder(
                      message: "No unassigned reviewees found.",
                    );
                  }
                  
                  if (isCheckedList.isEmpty) {
                    // Initialize isCheckedList if it hasn't been initialized yet
                    isCheckedList = List.filled(reviewees.length, false);
                  }

                  return ListView.separated(
                    itemCount: reviewees.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 25),
                    itemBuilder: (context, index) {
                      final reviewee = reviewees[index];

                      return AddRevieweeCard(
                        reviewee: reviewee,
                        isSelected: isCheckedList[index],
                        onCheckboxChanged: (value) {
                          setState(() {
                            isCheckedList[index] = value;
                          });
                        },
                      );
                    },
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stackTrace) => const Text('An error occurred'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
