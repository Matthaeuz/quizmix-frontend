import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/questions/question_bank_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_question_bank/question_bank_card.dart';
import 'package:quizmix_frontend/views/widgets/tiny_solid_button.dart';

class RevieweeMixView extends ConsumerWidget {
  const RevieweeMixView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // temporary MixQuestions, edit in integration
    final questions = ref.watch(questionBankProvider);

    return Expanded(
      flex: 5,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            color: AppColors.fourthColor,
            height: constraints.maxHeight,
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        'MyMix1',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 32),
                      ),
                    ),
                    TinySolidButton(
                      text: 'View Results',
                      icon: Icons.list,
                      buttonColor: AppColors.mainColor,
                      onPressed: () {
                        // to View Results
                      },
                    ),
                    const SizedBox(width: 10),
                    TinySolidButton(
                      text: 'View Mix',
                      icon: Icons.visibility_outlined,
                      buttonColor: AppColors.mainColor,
                      onPressed: () {
                        // to View Mix
                      },
                    ),
                    const SizedBox(width: 10),
                    TinySolidButton(
                      text: 'Answer Mix',
                      icon: Icons.check_circle_outlined,
                      buttonColor: AppColors.mainColor,
                      onPressed: () {
                        // to Answer Mix
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: questions.when(
                    data: (questions) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: questions.length,
                        itemBuilder: (context, index) {
                          return QuestionBankCard(
                            questionDetails: questions[index],
                          );
                        },
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                    error: (err, stack) => Text('Error: $err'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
