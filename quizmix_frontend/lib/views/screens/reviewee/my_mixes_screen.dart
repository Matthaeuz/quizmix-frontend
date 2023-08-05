/// The `MyMixesScreen` class is a Flutter widget that displays a screen for viewing a question
/// bank and allows users to search for questions and view individual questions.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_dashboard/reviewee_dashboard.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_my_mixes/reviewee_mix_add.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_my_mixes/reviewee_mix_list.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_my_mixes/reviewee_mix_view.dart';

class MyMixesScreen extends ConsumerStatefulWidget {
  const MyMixesScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MyMixesScreen> createState() => _MyMixesScreenState();
}

class _MyMixesScreenState extends ConsumerState<MyMixesScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Row(
            children: [
              // Left Section - Dashboard
              Expanded(
                flex: 2,
                child: Container(
                  color: Colors.white,
                  child: const Column(
                    children: [
                      // Left Side - Dashboard
                      RevieweeDashboardWidget(
                        selectedOption: 'My Mixes',
                      ),
                    ],
                  ),
                ),
              ),

              // Middle Section
              Expanded(
                flex: 3,
                child: Container(
                  color: AppColors.fifthColor,
                  padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Search Input
                      TextField(
                        decoration: const InputDecoration(
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
                        onChanged: (value) {
                          // Handle search input changes
                        },
                      ),
                      const SizedBox(height: 20),
                      const Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
                                child: RevieweeMixAdd(),
                              ),
                              MyMixList(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Right Section
              const RevieweeMixView()
            ],
          ),
        ),
      ],
    );
  }
}
