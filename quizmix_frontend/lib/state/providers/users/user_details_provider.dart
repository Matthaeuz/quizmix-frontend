import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/users/user.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';

class UserDetailsNotifier extends StateNotifier<User> {
  UserDetailsNotifier(User user) : super(user);

  void updateUser(User newUser) {
    state = newUser;
  }

  Future<void> updateReviewee(WidgetRef ref, Map<String, int> resp) async {
    final client = ref.watch(restClientProvider);
    final token = ref.watch(authTokenProvider);
    try {
      await client.updateScoresAndParams(token.accessToken, resp);
      final updatedUser =
          await client.getUserByEmail(token.accessToken, state.email);
      updateUser(updatedUser[0]);
    } catch (e) {
      return;
    }
  }
}

final userProvider = StateNotifierProvider<UserDetailsNotifier, User>((ref) {
  return UserDetailsNotifier(User.base());
});
