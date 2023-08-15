import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/quiz_attempts/quiz_attempt.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewee_details_provider.dart';

class RevieweeAttemptsNotifier extends StateNotifier<AsyncValue<List<QuizAttempt>>> {
  final RestClient client;
  final String accessToken;
  final int revieweeId;
  final int quizId;

  RevieweeAttemptsNotifier({
    required this.client,
    required this.accessToken,
    required this.revieweeId,
    required this.quizId,
  }) : super(const AsyncValue.loading()) {
    fetchRevieweeAttempts(revieweeId, quizId);
  }

  Future<void> fetchRevieweeAttempts(int revieweeId, int quizId) async {
    try {
      var revieweeAttempts = await client.getRevieweeAttemptsByQuiz(accessToken, revieweeId, quizId);
      state = AsyncValue.data(revieweeAttempts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final revieweeAttemptsProvider = StateNotifierProvider.family<RevieweeAttemptsNotifier, AsyncValue<List<QuizAttempt>>, int>((ref, quizId) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final revieweeId = ref.read(revieweeProvider).when(
    data: (data) => data.id,
    error: (err, st) => 0, 
    loading: () => 0, 
  );

  return RevieweeAttemptsNotifier(client: client, accessToken: token.accessToken, quizId: quizId, revieweeId: revieweeId);
});