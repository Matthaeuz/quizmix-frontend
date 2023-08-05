/// The `MyQuestionBankScreen` class is a Flutter widget that displays a screen for viewing a question
/// bank and allows users to search for questions and view individual questions.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/screens/reviewer/question_search_modal_screen.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_dashboard/reviewee_dashboard.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_question_bank/question_bank_list.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_question_bank/question_bank_question_view.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class MyQuestionBankScreen extends ConsumerStatefulWidget {
  const MyQuestionBankScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<MyQuestionBankScreen> createState() =>
      _MyQuestionBankScreenState();
}

class _MyQuestionBankScreenState extends ConsumerState<MyQuestionBankScreen> {
  bool isOpenModal = false;

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
                        selectedOption: 'Question Bank',
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
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SolidButton(
                                text: 'Search',
                                onPressed: () {
                                  setState(() {
                                    isOpenModal = true;
                                  });
                                },
                                icon: const Icon(Icons.search),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Expanded(
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
        ),
        isOpenModal == true
            ? Container(color: const Color(0x800077B6))
            : const SizedBox(),
        isOpenModal == true
            ? QuestionSearchModalScreen(onClick: () {
                setState(() {
                  isOpenModal = false;
                });
              })
            : const SizedBox(),
      ],
    );
  }
}
