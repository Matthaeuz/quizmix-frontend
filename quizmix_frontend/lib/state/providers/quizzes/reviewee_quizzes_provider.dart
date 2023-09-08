import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/models/quizzes/reviewee_quizzes_details.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';

class RevieweeQuizzesNotifier extends StateNotifier<AsyncValue<List<Quiz>>> {
  final RestClient client;
  final String accessToken;
  final int revieweeId;

  RevieweeQuizzesNotifier({
    required this.client,
    required this.accessToken,
    required this.revieweeId,
  }) : super(const AsyncValue.loading()) {
    fetchQuizzes();
  }

  Future<void> fetchQuizzes() async {
    try {
      final details = RevieweeQuizzesDetails(revieweeId: revieweeId);
      final quizzes = await client.getRevieweeQuizzes(accessToken, details);
      state = AsyncValue.data(quizzes);
    } catch (e, st) {
      if (e is DioException && e.response?.statusCode == 400) {
        state = const AsyncValue.data([]);
      } else {
        state = AsyncValue.error(e, st);
      }
    }
  }
}

final revieweeQuizzesProvider =
    StateNotifierProvider<RevieweeQuizzesNotifier, AsyncValue<List<Quiz>>>(
        (ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final revieweeId = ref.watch(userProvider).id;

  return RevieweeQuizzesNotifier(
      client: client, accessToken: token.accessToken, revieweeId: revieweeId);
});
