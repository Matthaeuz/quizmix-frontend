import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/mixes/mix.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_provider.dart';

class RevieweeMixCard extends ConsumerWidget {
  final Mix mixDetails;

  const RevieweeMixCard({
    Key? key,
    required this.mixDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(currentMixProvider.notifier).updateCurrentMix(mixDetails);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.fourthColor,
                borderRadius: BorderRadius.circular(5),
              ),
              child: mixDetails.image != null
                  ? Image(
                      image: NetworkImage(mixDetails.image!),
                      fit: BoxFit.cover,
                    )
                  : Center(
                      child: Text(
                        mixDetails.title[0],
                        style: const TextStyle(
                          color: AppColors.black,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                mixDetails.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
