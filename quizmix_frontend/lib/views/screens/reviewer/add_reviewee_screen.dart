import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/current_viewed_reviewee_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewer_reviewees_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';
import 'package:quizmix_frontend/views/screens/view_reviewee_profile_screen.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_reviewees_tab/reviewer_reviewee_item.dart';
import 'package:quizmix_frontend/state/providers/reviewees/unassigned_reviewees_provider.dart';

class AddRevieweeScreen extends ConsumerStatefulWidget {
  const AddRevieweeScreen({Key? key}) : super(key: key);

  @override
  AddRevieweeScreenState createState() => AddRevieweeScreenState();
}

class AddRevieweeScreenState extends ConsumerState<AddRevieweeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final client = ref.watch(restClientProvider);
    final token = ref.watch(authTokenProvider).accessToken;
    final unassignedReviewees = ref.watch(unassignedRevieweesProvider);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          unassignedReviewees.when(data: (data) {
            if (data.isEmpty) {
              return const Center(
                child: SingleChildScrollView(
                  child: EmptyDataPlaceholder(
                    message: "There are no unassigned reviewees to show",
                    color: AppColors.white,
                  ),
                ),
              );
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: screenHeight > 180 ? 120 : 0,
                    width: screenWidth,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 24, 0),
                    child: Wrap(
                      spacing: 24.0,
                      runSpacing: 24.0,
                      children: [
                        for (var index = 0; index < data.length; index++) ...[
                          ReviewerRevieweeItem(
                            reviewee: data[index],
                            action: ReviewerRevieweeAction.assign,
                            onClick: () {
                              ref
                                  .read(currentViewedRevieweeProvider.notifier)
                                  .updateCurrentReviewee(data[index]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ViewRevieweeProfileScreen(),
                                ),
                              );
                            },
                            onButtonPress: () async {
                              ref
                                  .read(unassignedRevieweesProvider.notifier)
                                  .setLoading();
                              final revieweeUAV = await client
                                  .getRevieweeBelongsTo(token, data[index].id);
                              await client.updateUserAttributeValue(token,
                                  {"value": "${user.id}"}, revieweeUAV[0].id);
                              await ref
                                  .read(reviewerRevieweesProvider.notifier)
                                  .fetchReviewerReviewees();
                              await ref
                                  .read(unassignedRevieweesProvider.notifier)
                                  .fetchUnassignedReviewees();
                            },
                          ),
                        ]
                      ],
                    ),
                  ),
                ],
              ),
            );
          }, error: (err, st) {
            return const Center(
              child: SingleChildScrollView(
                child: EmptyDataPlaceholder(
                  message: "Please try again later",
                  color: AppColors.white,
                ),
              ),
            );
          }, loading: () {
            return const Center(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 48.0,
                  height: 48.0,
                  child: CircularProgressIndicator(color: AppColors.white),
                ),
              ),
            );
          }),
          screenHeight > 180
              ? Container(
                  width: screenWidth,
                  padding: const EdgeInsets.all(24),
                  color: AppColors.mainColor.withOpacity(0.9),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          alignment: Alignment.centerLeft,
                          foregroundColor: AppColors.white,
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.arrow_back,
                              size: 16.0,
                              color: AppColors.white,
                            ),
                            Text("Back to Reviewees"),
                          ],
                        ),
                      ),
                      const Text(
                        "Assign Reviewees",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
