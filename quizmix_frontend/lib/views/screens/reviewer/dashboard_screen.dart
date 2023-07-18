import 'package:flutter/material.dart';
import 'package:quizmix_frontend/views/widgets/dashboard.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

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
              color: const Color(0xFFCAF0F8),
            ),
          ),
        ],
      ),
    );
  }
}
