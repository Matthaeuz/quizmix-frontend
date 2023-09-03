import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_question_bank/question_bank_list.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_question_bank/question_bank_question_view.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class RevieweeQuestionBankTab extends ConsumerStatefulWidget {
  const RevieweeQuestionBankTab({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RevieweeQuestionBankTab> createState() =>
      _RevieweeQuestionBankTabState();
}

class _RevieweeQuestionBankTabState
    extends ConsumerState<RevieweeQuestionBankTab> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
                          onPressed: () {},
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
    );
  }
}
