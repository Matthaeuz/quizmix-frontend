import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/users/user.dart';
import 'package:quizmix_frontend/state/providers/reviewees/current_viewed_reviewee_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';
import 'package:quizmix_frontend/views/screens/view_reviewee_profile_screen.dart';

class ProfileArea extends ConsumerWidget {
  const ProfileArea({Key? key}) : super(key: key);

  Widget buildProfileArea(User details) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: LayoutBuilder(builder: (context, constraints) {
        final parentWidth = constraints.maxWidth;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Circular Picture
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 2,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: ClipOval(
                  clipBehavior: Clip.antiAlias,
                  child: Image(
                    width: 60,
                    height: 60,
                    image: details.image != null && details.image!.isNotEmpty
                        ? NetworkImage(details.image!)
                        : const AssetImage('lib/assets/images/default_pic.png')
                            as ImageProvider<Object>,
                    fit: BoxFit.cover,
                  ),
                ),
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
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(userProvider);

    if (details.role == "reviewee") {
      return InkWell(
        onTap: () {
          ref
              .read(currentViewedRevieweeProvider.notifier)
              .updateCurrentReviewee(details);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ViewRevieweeProfileScreen()));
        },
        child: buildProfileArea(details),
      );
    }
    return buildProfileArea(details);
  }
}
