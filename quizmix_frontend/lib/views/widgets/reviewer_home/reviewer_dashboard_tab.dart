import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_dashboard/my_quizzes_list.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_dashboard/my_reviewees_list.dart';

class ReviewerDashboardTab extends ConsumerStatefulWidget {
  const ReviewerDashboardTab({Key? key}) : super(key: key);

  @override
  ConsumerState<ReviewerDashboardTab> createState() =>
      _ReviewerDashboardTabState();
}

class _ReviewerDashboardTabState extends ConsumerState<ReviewerDashboardTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainColor,
      child: const Padding(
        padding: EdgeInsets.fromLTRB(25, 25, 25, 0),
        child: Column(
          children: [
            MyQuizzesList(),
            SizedBox(height: 25),
            MyRevieweesList(),
          ],
        ),
      ),
    );
  }
}
