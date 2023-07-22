import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/providers/reviewees/unassigned_reviewees_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_dashboard/dashboard.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_list_card.dart';

class RevieweesListScreen extends ConsumerWidget {
  const RevieweesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewees = ref.watch(unassignedRevieweesProvider);

    return Scaffold(
      body: Row(
        children: [
          // Left Side - Dashboard
          const DashboardWidget(
            selectedOption: 'Reviewees',
          ),
          // Right Side - Background Color
          Expanded(
            flex: 8,
            child: Container(
              color: const Color(0xFFCAF0F8),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FractionallySizedBox(
                      widthFactor: 0.4,
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.search),
                          hintText: 'Search',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                      ),
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
