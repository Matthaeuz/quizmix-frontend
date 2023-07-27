import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/auth/auth_token.dart';

class AuthTokenNotifier extends StateNotifier<AuthToken> {
  AuthTokenNotifier(AuthToken token) : super(token);

  void updateToken(AuthToken authDetails) {
    state = authDetails;
  }
}

final authTokenProvider = StateNotifierProvider<AuthTokenNotifier, AuthToken>((ref) {
  return AuthTokenNotifier(AuthToken.base());
});