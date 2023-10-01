import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/quiz_attempts/quiz_attempt.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/current_viewed_reviewee_provider.dart';

class RevieweeRecentAttemptsNotifier
    extends StateNotifier<AsyncValue<List<QuizAttempt>>> {
  final RestClient client;
  final String accessToken;
  final int revieweeId;

  RevieweeRecentAttemptsNotifier({
    required this.client,
    required this.accessToken,
    required this.revieweeId,
  }) : super(const AsyncValue.loading()) {
    fetchRevieweeRecentAttempts();
  }

  Future<void> fetchRevieweeRecentAttempts() async {
    try {
      final revieweeRecentAttempts =
          await client.getRevieweeAttempts(accessToken, revieweeId);
      revieweeRecentAttempts.sort((a, b) => a.id.compareTo(b.id));
      state = AsyncValue.data(revieweeRecentAttempts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final revieweeRecentAttemptsProvider = StateNotifierProvider<
    RevieweeRecentAttemptsNotifier, AsyncValue<List<QuizAttempt>>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final reviewee = ref.watch(currentViewedRevieweeProvider);

  return RevieweeRecentAttemptsNotifier(
    client: client,
    accessToken: token.accessToken,
    revieweeId: reviewee.id,
  );
});
