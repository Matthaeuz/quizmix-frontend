import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/auth/auth_token.dart';

// class AuthDetailsNotifier extends StateNotifier<User> {
//   AuthDetailsNotifier(User user) : super(user);

//   void updateUser(User newUser) {
//     state = User(
//       displayName: newUser.displayName,
//       userId: newUser.userId,
//       email: newUser.email,
//     );
//   }
// }

// final authDetailsProvider = StateNotifierProvider<AuthDetailsNotifier, User>((ref) {
//   return AuthDetailsNotifier(User.base());
// });

class AuthTokenNotifier extends StateNotifier<AuthToken> {
  AuthTokenNotifier(AuthToken token) : super(token);

  void updateToken(AuthToken authDetails) {
    state = AuthToken(
      access: authDetails.access,
      refresh: authDetails.refresh,
    );
  }
}

final authTokenProvider = StateNotifierProvider<AuthTokenNotifier, AuthToken>((ref) {
  return AuthTokenNotifier(AuthToken.base());
});