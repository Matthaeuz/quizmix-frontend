import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/datetime_convert.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/mixes/mix.dart';
import 'package:quizmix_frontend/state/providers/mixes/answer_mix_responses_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewee/answer_mix_screen.dart';
import 'package:quizmix_frontend/views/screens/reviewee/view_mix_screen.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class RevieweeMixItem extends ConsumerWidget {
  final Mix mix;

  const RevieweeMixItem({super.key, required this.mix});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: 352,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12), // Add border radius of 5
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: AppColors.fourthColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: mix.image != null
                        ? Image(
                            image: NetworkImage(mix.image!),
                            fit: BoxFit.cover,
                          )
                        : Center(
                            child: Text(
                              mix.title[0],
                              style: const TextStyle(
                                color: AppColors.black,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mix.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "${mix.numQuestions} ${mix.numQuestions > 1 ? "questions" : "question"}, ${mix.numCategories} ${mix.numCategories > 1 ? "categories" : "category"}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "Created on: ${dateTimeToWordDate(mix.createdOn)}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: SolidButton(
                    onPressed: () {
                      ref
                          .read(currentMixProvider.notifier)
                          .updateCurrentMix(mix);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ViewMixScreen(),
                        ),
                      );
                    },
                    text: 'View Mix',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SolidButton(
                    onPressed: () {
                      ref
                          .read(currentMixProvider.notifier)
                          .updateCurrentMix(mix);
                      ref
                          .read(answerMixResponsesProvider.notifier)
                          .initialize();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AnswerMixScreen(),
                        ),
                      );
                    },
                    text: 'Answer Mix',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
