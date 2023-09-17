import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';

class RevieweeTopCategories extends ConsumerWidget {
  const RevieweeTopCategories({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    'Your Top Categories',
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text('Category', style: TextStyle(fontSize: 16)),
                      ),
                      Expanded(
                        flex: 1,
                        child: Text('Score', style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  ),
                ),
                // topScores != null
                //     ? ListView.builder(
                //         shrinkWrap: true,
                //         physics: const NeverScrollableScrollPhysics(),
                //         itemCount: topScores.categories.length,
                //         itemBuilder: (context, index) {
                //           final categories = topScores.categories;
                //           final scores = topScores.scores;
                //           return Padding(
                //             padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                //             child: Row(
                //               children: [
                //                 Expanded(
                //                   flex: 3,
                //                   child: Text(categories[index],
                //                       style: const TextStyle(fontSize: 14)),
                //                 ),
                //                 Expanded(
                //                   flex: 1,
                //                   child: Text(scores[index].toStringAsFixed(4),
                //                       style: const TextStyle(fontSize: 14)),
                //                 ),
                //               ],
                //             ),
                //           );
                //         },
                //       )
                //     : const SizedBox(),
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
