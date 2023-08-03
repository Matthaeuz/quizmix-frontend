import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewee_history_scores_provider.dart';

class MyQuizHistory extends ConsumerWidget {
  const MyQuizHistory({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final attempts = ref.watch(revieweeHistoryScoresProvider).when(
          data: (data) {
            return data;
          },
          error: (err, st) {},
          loading: () {},
        );

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
      decoration: BoxDecoration(
        color: AppColors.fifthColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Your History',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: attempts != null && attempts.isNotEmpty
                      ? const Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text('Quiz Name',
                                  style: TextStyle(fontSize: 16)),
                            ),
                            Expanded(
                              flex: 1,
                              child:
                                  Text('Score', style: TextStyle(fontSize: 16)),
                            ),
                          ],
                        )
                      : const Align(
                          alignment: Alignment.topCenter,
                          child: Text('You have no quiz attempts yet.',
                              style: TextStyle(fontSize: 16)),
                        ),
                ),
                attempts != null && attempts.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: attempts.length <= 6 ? attempts.length : 6,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            margin: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                    child: Text(
                                      attempts[index].quizName,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 8, 8, 8),
                                    child: Text(
                                      '${attempts[index].score}/${attempts[index].numQuestions}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
                    : const SizedBox(),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: InkWell(
                    onTap: () {
                      // Add your code for handling "See All" press here
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'See All',
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
