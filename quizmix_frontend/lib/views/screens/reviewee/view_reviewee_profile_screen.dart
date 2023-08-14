import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/providers/api/base_url_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewee_details_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_view_profile/my_categories.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_view_profile/my_quiz_history.dart';

class ViewRevieweeProfileScreen extends ConsumerWidget {
  const ViewRevieweeProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseUrl = ref.read(baseUrlProvider);

    double sectionWidth = MediaQuery.of(context).size.width * 0.8;
    double cardWidth = sectionWidth / 2 <= 200 ? double.infinity : 300;
    final revieweeDetails = ref.watch(revieweeProvider).when(
          data: (data) {
            return data;
          },
          error: (err, st) {},
          loading: () {},
        );
    ImageProvider? imageProvider;
    if (revieweeDetails!.user.image != null &&
        revieweeDetails.user.image!.isNotEmpty) {
      imageProvider = NetworkImage(baseUrl + revieweeDetails.user.image!);
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
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
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
                      revieweeDetails.user.fullName,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 25),
                    // Your Stats
                    Container(
                      width: sectionWidth,
                      margin: const EdgeInsets.only(bottom: 40),
                      child: Wrap(
                        spacing: 25,
                        runSpacing: 25,
                        alignment: WrapAlignment.center,
                        children: [
                          MyCategories(
                            width: cardWidth,
                            height: 365,
                          ),
                          MyQuizHistory(
                            width: cardWidth,
                            height: 365,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
