import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/api/base_url_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/current_viewed_reviewee_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/views/modals/view_reviewee_recent_attempts_modal.dart';
import 'package:quizmix_frontend/views/widgets/view_reviewee_profile/reviewee_recent_attempts.dart';

class ViewRevieweeProfileScreen extends ConsumerWidget {
  const ViewRevieweeProfileScreen({Key? key}) : super(key: key);

  static const BoxConstraints detailsBoxConstraintsA = BoxConstraints(
    minWidth: 400.0,
    minHeight: 800.0,
    maxHeight: 800.0,
    maxWidth: 600.0,
  );
  static const BoxConstraints detailsBoxConstraintsB = BoxConstraints(
    minWidth: 400.0,
    minHeight: 600.0,
    maxWidth: 600.0,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseUrl = ref.read(baseUrlProvider);
    final revieweeDetails = ref.watch(currentViewedRevieweeProvider);
    final modalState = ref.watch(modalStateProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    ImageProvider? imageProvider;
    if (revieweeDetails.image != null && revieweeDetails.image!.isNotEmpty) {
      imageProvider = NetworkImage(baseUrl + revieweeDetails.image!);
    } else {
      imageProvider = const AssetImage("lib/assets/images/default_pic.png");
    }

    return Stack(
      children: [
        Scaffold(
          appBar: null,
          body: SingleChildScrollView(
            child: Container(
              width: screenWidth,
              color: AppColors.secondaryColor,
              padding: EdgeInsets.fromLTRB(
                  0, screenHeight * 0.05, 0, screenHeight * 0.05),
              child: Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    width: 400,
                    child: Column(
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
                              Text('Back to Home'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Circle Picture
                        Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 16,
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                          child: ClipOval(
                            clipBehavior: Clip.antiAlias,
                            child: Image(
                              width: 180,
                              height: 180,
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        // Name
                        Text(
                          revieweeDetails.fullName,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                        const Text(
                          "Reviewee",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Email: ${revieweeDetails.email}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.9,
                    constraints:
                        screenHeight >= detailsBoxConstraintsA.minHeight
                            ? detailsBoxConstraintsA
                            : detailsBoxConstraintsB,
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(20.0),
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
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Top Categories",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {},
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        alignment: Alignment.centerLeft,
                                        foregroundColor: AppColors.mainColor,
                                      ),
                                      child: const Text("See All"),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.4),
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: const Offset(0, 0),
                                ),
                              ],
                            ),
                            child: const RevieweeRecentAttempts(),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        if (modalState == ModalState.preparingReview) ...[
          Scaffold(
            body: Container(
              color: AppColors.mainColor,
              child: const Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 48.0,
                        width: 48.0,
                        child: CircularProgressIndicator(
                          strokeWidth: 6.0,
                          color: AppColors.white,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        "Preparing Review...",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ] else if (modalState == ModalState.viewRevieweeRecentAttempts) ...[
          Container(
            color: AppColors.fourthColor.withOpacity(0.8),
            child: const ViewRevieweeRecentAttemptsModal(),
          ),
        ]
      ],
    );
  }
}
