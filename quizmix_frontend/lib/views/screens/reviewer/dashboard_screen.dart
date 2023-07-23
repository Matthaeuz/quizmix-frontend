import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/widgets/dashboard.dart';
import 'package:quizmix_frontend/views/widgets/dashboard_item_list_container.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    DashboardItemListContainer(myQuizzesText: 'My Quizzes'),
                    SizedBox(height: 25),
                    DashboardItemListContainer(
                        myQuizzesText: 'My Reviewees', useImages: true),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
