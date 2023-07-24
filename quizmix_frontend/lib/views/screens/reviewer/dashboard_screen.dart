import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/views/widgets/dashboard.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_dashboard/my_quizzes_list.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_dashboard/my_reviewees_list.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Row(
        children: [
          // Left Side - Dashboard
          const DashboardWidget(
            selectedOption: 'Dashboard',
          ),
          // Right Side - Background Color
          Expanded(
            flex: 8,
            child: Container(
                color: AppColors.fifthColor,
                padding: const EdgeInsets.all(25),
                child: const Column(
                  children: [
                    MyQuizzesList(),
                    SizedBox(height: 25),
                    MyRevieweesList(),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
