import 'package:flutter_riverpod/flutter_riverpod.dart';

class CurrentEmailNotifier extends StateNotifier<String> {
  CurrentEmailNotifier(String email) : super(email);

  void updateEmail(String newEmail) {
    state = newEmail;
  }
}

final currentEmailProvider = StateNotifierProvider<CurrentEmailNotifier, String>((ref) {
  return CurrentEmailNotifier("");
});