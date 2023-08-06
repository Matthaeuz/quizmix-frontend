import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_dashboard/reviewee_dashboard.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_question_bank/question_bank_list.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_question_bank/question_bank_question_view.dart';

class ViewQuestionBankScreen extends ConsumerWidget {
  const ViewQuestionBankScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
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
                  RevieweeDashboardWidget(selectedOption: 'Question Bank')
                ],
              ),
            ),
          ),

          // Middle Section
          Expanded(
            flex: 3,
            child: Container(
              color: AppColors.fifthColor,
              child: const Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(25),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 1,
                            child: FractionallySizedBox(
                              widthFactor: 0.9, // Adjust this value as needed
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
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 10),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          children: [QuestionBankList()],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right Section
          const QuestionBankQuestion()
        ],
      ),
    );
  }
}
