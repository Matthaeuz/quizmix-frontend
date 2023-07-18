import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/reviewees/reviewee.dart';

class RevieweeDetailsNotifier extends StateNotifier<Reviewee> {
  RevieweeDetailsNotifier(Reviewee reviewee) : super(reviewee);

  void updateReviewee(Reviewee newReviewee) {
    state = Reviewee(
      id: newReviewee.id,
      user: newReviewee.user,
      belongsTo: newReviewee.belongsTo,
      categoryScores: newReviewee.categoryScores
    );
  }
}

final revieweeProvider = StateNotifierProvider<RevieweeDetailsNotifier, Reviewee>((ref) {
  return RevieweeDetailsNotifier(Reviewee.base());
});