import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/datetime_convert.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/users/user.dart';
import 'package:quizmix_frontend/state/providers/api/base_url_provider.dart';
import 'package:quizmix_frontend/views/widgets/tiny_solid_button.dart';

enum ReviewerRevieweeAction { assign, unassign }

class ReviewerRevieweeItem extends ConsumerWidget {
  final User reviewee;
  final ReviewerRevieweeAction action;
  final Function() onClick;
  final Function() onButtonPress;

  const ReviewerRevieweeItem({
    Key? key,
    required this.reviewee,
    required this.action,
    required this.onClick,
    required this.onButtonPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseUrl = ref.read(baseUrlProvider);
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          constraints: const BoxConstraints(minWidth: 354),
          padding: const EdgeInsets.fromLTRB(12, 12, 24, 12),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
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
                  child: reviewee.image != null
                      ? Image(
                          image: NetworkImage(baseUrl + reviewee.image!),
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Text(
                            reviewee.fullName[0],
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
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      reviewee.fullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Joined: ${dateTimeToWordDate(reviewee.createdOn)}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    TinySolidButton(
                      text: action == ReviewerRevieweeAction.assign
                          ? "Assign"
                          : "Unassign",
                      icon: action == ReviewerRevieweeAction.assign
                          ? Icons.add
                          : Icons.remove,
                      buttonColor: AppColors.red,
                      onPressed: onButtonPress,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
