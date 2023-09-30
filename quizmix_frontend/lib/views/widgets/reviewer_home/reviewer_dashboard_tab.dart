import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_dashboard/recent_attempts_card.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_top_categories/reviewer_top_category_container.dart';

class ReviewerDashboardTab extends ConsumerWidget {
  const ReviewerDashboardTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      color: AppColors.mainColor,
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(15),
                          child: ReviewerTopCategories(),
                        )),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                      child: const SizedBox(
                        child: Center(
                          child: Text('Top Reviewees',
                              style: TextStyle(color: Colors.black)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Expanded(child: RecentPretestAttemptsCard())
          ],
        ),
      ),
    );
  }
}
