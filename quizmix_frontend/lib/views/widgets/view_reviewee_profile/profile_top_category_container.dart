import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/category_scores/category_score.dart';

class ProfileTopCategoryContainer extends StatelessWidget {
  final CategoryScore categoryScore;
  final int index;

  const ProfileTopCategoryContainer({
    super.key,
    required this.categoryScore,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.iconColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Text(
              "${index + 1}. ${categoryScore.category}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              categoryScore.score.toStringAsFixed(8),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
