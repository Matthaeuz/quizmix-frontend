import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/reviewees/unassigned_reviewees_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewer/add_reviewee_screen.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_dashboard/reviewer_dashboard.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_list_card.dart';
import 'package:quizmix_frontend/views/widgets/search_input.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class RevieweesListScreen extends ConsumerWidget {
  const RevieweesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewees = ref.watch(unassignedRevieweesProvider);

    return Scaffold(
      body: Row(
        children: [
          // Left Side - Dashboard
          const ReviewerDashboardWidget(
            selectedOption: 'Reviewees',
          ),
          // Right Side - Background Color
          Expanded(
            flex: 8,
            child: Container(
              color: AppColors.fifthColor,
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
                                // Handle search input changes
                              },
                            ),
                          ),
                        ),
                        // Add Reviewee Button - On the very right
                        SolidButton(
                          text: 'Add Reviewee',
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddRevieweeScreen()));
                          },
                          icon: const Icon(Icons.person_add),
                        ),
                      ],
                    ),
                    // List
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: reviewees.when(
                          data: (reviewees) => GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 25,
                              mainAxisSpacing: 25,
                              mainAxisExtent: 125,
                            ),
                            itemCount: reviewees.length,
                            itemBuilder: (context, index) {
                              return RevieweeListCard(
                                revieweeDetails: reviewees[index],
                              );
                            },
                          ),
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (err, stack) => Text('Error Found: $err'),
                        ),
                      ),
                    ),
                    const SizedBox(height: 25)
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
