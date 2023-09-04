import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewee_history_scores_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewee_top_scores_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewee/view_reviewee_profile_screen.dart';
import 'package:quizmix_frontend/views/screens/reviewer/view_reviewer_profile_screen.dart';

class ProfileArea extends ConsumerWidget {
  const ProfileArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(userProvider);

    return InkWell(
      onTap: () {
        if (details.role == "reviewee") {
          ref.read(revieweeTopScoresProvider.notifier).fetchRevieweeTopScores();
          ref
              .read(revieweeHistoryScoresProvider.notifier)
              .fetchRevieweeHistoryScores();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ViewRevieweeProfileScreen()));
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ViewReviewerProfileScreen(),
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
        child: LayoutBuilder(builder: (context, constraints) {
          final parentWidth = constraints.maxWidth;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Circular Picture
              Align(
                alignment: Alignment.centerLeft,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: details.image != null &&
                          details.image!.isNotEmpty
                      ? NetworkImage(details.image!)
                      : const AssetImage('lib/assets/images/default_pic.png')
                          as ImageProvider<Object>,
                ),
              ),
              if (parentWidth > 92) ...[
                const SizedBox(width: 16),
                // Text Information
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        details.fullName,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        details.email,
                        style: const TextStyle(
                          fontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          );
        }),
      ),
    );
  }
}
