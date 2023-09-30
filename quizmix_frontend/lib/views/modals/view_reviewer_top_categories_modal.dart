import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/reviewers/reviewer_top_categories_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/view_reviewee_profile/profile_top_category_container.dart';

class ViewReviewerTopCategoriesModal extends ConsumerStatefulWidget {
  const ViewReviewerTopCategoriesModal({Key? key}) : super(key: key);

  @override
  ConsumerState<ViewReviewerTopCategoriesModal> createState() =>
      _ViewReviewerTopCategoriesModalState();
}

class _ViewReviewerTopCategoriesModalState
    extends ConsumerState<ViewReviewerTopCategoriesModal> {
  @override
  Widget build(BuildContext context) {
    final topCategories = ref.watch(reviewerTopCategoriesProvider);

    return Scaffold(
      appBar: null,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(
            width: 800,
            padding: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                    onPressed: () {
                      ref
                          .read(modalStateProvider.notifier)
                          .updateModalState(ModalState.none);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      foregroundColor: AppColors.mainColor,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 16.0,
                          color: AppColors.mainColor,
                        ),
                        Text('Back to Reviewee Profile'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Top Categories",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  topCategories.when(
                    data: (data) {
                      if (data.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: EmptyDataPlaceholder(
                              message: "There are no category scores to show",
                            ),
                          ),
                        );
                      }
                      return Column(
                        children: [
                          for (var index = 0; index < data.length; index++) ...[
                            Padding(
                              padding: const EdgeInsets.only(bottom: 4),
                              child: ProfileTopCategoryContainer(
                                categoryScore: data[index],
                                index: index,
                              ),
                            ),
                          ]
                        ],
                      );
                    },
                    error: (error, stack) => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: EmptyDataPlaceholder(
                          message: "Please try again later",
                        ),
                      ),
                    ),
                    loading: () => const Center(
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 32.0,
                              width: 32.0,
                              child: CircularProgressIndicator(),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              'Loading Category Scores...',
                              style: TextStyle(
                                fontSize: 16.0,
                                color: AppColors.mainColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
