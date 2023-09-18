import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewee_top_categories_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/view_reviewee_profile/profile_top_category_container.dart';

class RevieweeTopCategories extends ConsumerWidget {
  const RevieweeTopCategories({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topCategories = ref.watch(revieweeTopCategoriesProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Top Categories",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {
                ref
                    .read(modalStateProvider.notifier)
                    .updateModalState(ModalState.viewRevieweeTopCategories);
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                alignment: Alignment.center,
                foregroundColor: AppColors.mainColor,
              ),
              child: const Text("See All"),
            ),
          ],
        ),
        const SizedBox(height: 4),
        topCategories.when(
          data: (data) {
            if (data.isEmpty) {
              return const Expanded(
                child: Center(
                  child: EmptyDataPlaceholder(
                    message: "There are no category scores to show",
                    color: AppColors.mainColor,
                  ),
                ),
              );
            }
            return Expanded(
              child: Column(
                children: [
                  for (var index = 0;
                      index < (data.length < 5 ? data.length : 5);
                      index++) ...[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: ProfileTopCategoryContainer(
                        categoryScore: data[index],
                        index: index,
                      ),
                    ),
                  ]
                ],
              ),
            );
          },
          error: (err, st) {
            return const Expanded(
              child: Center(
                child: EmptyDataPlaceholder(
                  message: "Please try again later",
                  color: AppColors.mainColor,
                ),
              ),
            );
          },
          loading: () {
            return const Expanded(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ],
    );
  }
}
