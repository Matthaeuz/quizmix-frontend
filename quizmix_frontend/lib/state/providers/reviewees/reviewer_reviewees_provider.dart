import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/reviewees/reviewee.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewers/reviewer_details_provider.dart';

class ReviewerRevieweesNotifier extends StateNotifier<AsyncValue<List<Reviewee>>> {
  final RestClient client;
  final String accessToken;
  final int reviewerId;

  ReviewerRevieweesNotifier({
    required this.client,
    required this.accessToken,
    required this.reviewerId,
  }) : super(const AsyncValue.loading()) {
    fetchReviewerReviewees();
  }

  Future<void> fetchReviewerReviewees() async {
    try {
      var reviewees = await client.getReviewerReviewees(accessToken, reviewerId);
      state = AsyncValue.data(reviewees);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final reviewerRevieweesProvider =
    StateNotifierProvider<ReviewerRevieweesNotifier, AsyncValue<List<Reviewee>>>(
        (ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final reviewerId = ref.watch(reviewerProvider).id;

  return ReviewerRevieweesNotifier(
      client: client, accessToken: token.accessToken, reviewerId: reviewerId);
});
