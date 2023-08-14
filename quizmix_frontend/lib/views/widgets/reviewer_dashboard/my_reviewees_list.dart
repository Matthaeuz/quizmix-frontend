import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewer_reviewees_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_dashboard/add_card.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_dashboard/my_quizzes_list.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_dashboard/reviewee_detail_card.dart';

class MyRevieweesList extends ConsumerWidget {
  const MyRevieweesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewees = ref.watch(reviewerRevieweesProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "My Reviewees",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.mainColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Handle View All onPress
              },
              child: const Text(
                'View All',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        reviewees.when(
          data: (revieweesData) => SizedBox(
              height: 200,
              child: ScrollConfiguration(
                behavior: MyCustomScrollBehavior(),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: const ClampingScrollPhysics(),
                  itemCount: revieweesData.length + 1,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 25),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return const AddCard(type: "reviewees");
                    } else {
                      final reviewee = revieweesData[index - 1];
                      final String name = reviewee.user.fullName;
                      final String? profilePicture = reviewee.user.image;
                      return RevieweeDetailCard(
                          title: name, image: profilePicture);
                    }
                  },
                ),
              )),
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ),
      ],
    );
  }
}
