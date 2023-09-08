import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/models/quizzes/tos.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';

class ReviewerQuizzesNotifier extends StateNotifier<AsyncValue<List<Quiz>>> {
  final RestClient client;
  final String accessToken;
  final int reviewerId;

  ReviewerQuizzesNotifier({
    required this.client,
    required this.accessToken,
    required this.reviewerId,
  }) : super(const AsyncValue.loading()) {
    fetchQuizzes();
  }

  // TODO: fix the implementation
  Future<void> fetchQuizzes() async {
    try {
      final quizzes = await client.getMadeByQuizzes(accessToken, reviewerId);
      state = AsyncValue.data(quizzes);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addQuiz(TOS tos) async {
    try {
      await client.createQuizFromTOS(accessToken, tos);
      fetchQuizzes(); // Refetch quizzes after adding.
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final reviewerQuizzesProvider =
    StateNotifierProvider<ReviewerQuizzesNotifier, AsyncValue<List<Quiz>>>(
        (ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final reviewerId = ref.watch(userProvider).id;

  return ReviewerQuizzesNotifier(
      client: client, accessToken: token.accessToken, reviewerId: reviewerId);
});
