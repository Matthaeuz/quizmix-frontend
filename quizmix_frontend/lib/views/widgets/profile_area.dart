import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';

class ProfileArea extends ConsumerWidget {
  const ProfileArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final details = ref.watch(userProvider);

    return Container(
      padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Circular Picture
          const Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              radius: 30,
              // backgroundImage:
              //     AssetImage('assets/images/ProfilePicture.jpg'),
            ),
          ),
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
      ),
    );
  }
}
