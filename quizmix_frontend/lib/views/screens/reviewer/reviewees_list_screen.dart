import 'package:flutter/material.dart';
import 'package:quizmix_frontend/views/widgets/dashboard.dart';

class RevieweesListScreen extends StatelessWidget {
  const RevieweesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            ),
          ),
        ],
      ),
    );
  }
}
