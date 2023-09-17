import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/models/users/user.dart';

class CurrentViewedRevieweeNotifier extends StateNotifier<User> {
  CurrentViewedRevieweeNotifier(User reviewee) : super(reviewee);

  void updateCurrentReviewee(User newReviewee) {
    state = newReviewee;
  }
}

final currentViewedRevieweeProvider =
    StateNotifierProvider<CurrentViewedRevieweeNotifier, User>((ref) {
  return CurrentViewedRevieweeNotifier(User.base());
});
