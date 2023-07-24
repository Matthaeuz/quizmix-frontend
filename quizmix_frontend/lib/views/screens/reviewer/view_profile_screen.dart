import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/reviewers/reviewer_details_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_view_profile/reviewer_quizzes_list.dart';

class ViewProfileScreen extends ConsumerWidget {
  const ViewProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewerDetails = ref.watch(reviewerProvider);
    ImageProvider? imageProvider;
    if (reviewerDetails.user.image != null && reviewerDetails.user.image!.isNotEmpty) {
        imageProvider = NetworkImage(reviewerDetails.user.image!);
    } else {
        imageProvider = const AssetImage("lib/assets/images/default_pic.png");
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Circle Picture
                  CircleAvatar(
                    radius: 90,
                    backgroundImage: imageProvider,
                  ),
                  const SizedBox(height: 25),
                  // Name
                  Text(
                    reviewerDetails.user.fullName,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),
                  // Your Quizzes
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: const EdgeInsets.only(bottom: 50),
                      decoration: BoxDecoration(
                          color: AppColors.fifthColor,
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Your Quizzes',
                              style: TextStyle(
                                fontSize: 28,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Quiz Name',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Total Items',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: Container()),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            // Add your code for handling "See All" press here
                                          },
                                          child: const Row(
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
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            // Quiz Items
                            const ReviewerQuizzesList(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
