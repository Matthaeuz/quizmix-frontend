import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/users/user.dart';

class UserDetailsNotifier extends StateNotifier<User> {
  UserDetailsNotifier(User user) : super(user);

  void updateUser(User newUser) {
    state = newUser;
  }
}

final userProvider = StateNotifierProvider<UserDetailsNotifier, User>((ref) {
  return UserDetailsNotifier(User.base());
});
