import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/models/auth/auth_token.dart';
import 'package:quizmix_frontend/state/models/users/user.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';
import 'package:quizmix_frontend/views/screens/login_screen.dart';

class SignOutArea extends ConsumerWidget {
  const SignOutArea({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        final parentWidth = constraints.maxWidth;

        return InkWell(
          onTap: () {
            ref.read(userProvider.notifier).updateUser(User.base());
            ref.read(authTokenProvider.notifier).updateToken(AuthToken.base());
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginScreen()));
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(8.0),
                  child: const Icon(
                    Icons.exit_to_app,
                    size: 44,
                  ),
                ),
                if (parentWidth > 112) ...[
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      'Sign Out',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }
}
