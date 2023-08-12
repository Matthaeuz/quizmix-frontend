import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewee/view_mix_screen.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_my_mixes/reviewee_mix_question_card.dart';
import 'package:quizmix_frontend/views/widgets/tiny_solid_button.dart';

class RevieweeMixView extends ConsumerWidget {
  const RevieweeMixView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // temporary MixQuestions, edit in integration
    final mix = ref.watch(currentMixProvider);

    return Expanded(
      flex: 5,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            color: AppColors.fourthColor,
            height: constraints.maxHeight,
            padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
            child: mix != null
                ? Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              mix.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(fontSize: 32),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ViewMixScreen()));
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
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: mix.questions.length,
                          itemBuilder: (context, index) {
                            return RevieweeMixQuestionCard(
                              questionDetails: mix.questions[index],
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          );
        },
      ),
    );
  }
}
