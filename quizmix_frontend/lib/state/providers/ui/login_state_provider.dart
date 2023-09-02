import 'package:flutter_riverpod/flutter_riverpod.dart';

enum LoginState { loginScreen, signUpScreen, loggingIn, signingUp }

class LoginStateNotifier extends StateNotifier<LoginState> {
  LoginStateNotifier(LoginState initLoginState) : super(initLoginState);

  void updateLoginState(LoginState newLoginState) {
    state = newLoginState;
  }
}

final loginStateProvider =
    StateNotifierProvider<LoginStateNotifier, LoginState>((ref) {
  return LoginStateNotifier(LoginState.loginScreen);
});
