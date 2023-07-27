import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/reviewees/reviewee.dart';

class RevieweeDetailsNotifier extends StateNotifier<Reviewee> {
  RevieweeDetailsNotifier(Reviewee reviewee) : super(reviewee);

  void updateReviewee(Reviewee newReviewee) {
    state = newReviewee;
  }
}

final revieweeProvider = StateNotifierProvider<RevieweeDetailsNotifier, Reviewee>((ref) {
  return RevieweeDetailsNotifier(Reviewee.base());
});