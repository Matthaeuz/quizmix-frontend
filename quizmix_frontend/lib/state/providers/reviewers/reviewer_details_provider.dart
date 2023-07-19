import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/reviewers/reviewer.dart';

class ReviewerDetailsNotifier extends StateNotifier<Reviewer> {
  ReviewerDetailsNotifier(Reviewer reviewer) : super(reviewer);

  void updateReviewee(Reviewer newReviewer) {
    state = Reviewer(
      id: newReviewer.id,
      user: newReviewer.user,
    );
  }
}

final reviewerProvider = StateNotifierProvider<ReviewerDetailsNotifier, Reviewer>((ref) {
  return ReviewerDetailsNotifier(Reviewer.base());
});