import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/users/user.dart';

class UserDetailsNotifier extends StateNotifier<User> {
  UserDetailsNotifier(User user) : super(user);

  void updateUser(User newUser) {
    state = User(
      id: newUser.id,
      email: newUser.email,
      firstName: newUser.firstName,
      middleName: newUser.middleName,
      lastName: newUser.lastName,
      image: newUser.image,
      isActive: newUser.isActive,
      createdOn: newUser.createdOn,
    );
  }
}

final userProvider = StateNotifierProvider<UserDetailsNotifier, User>((ref) {
  return UserDetailsNotifier(User.base());
});