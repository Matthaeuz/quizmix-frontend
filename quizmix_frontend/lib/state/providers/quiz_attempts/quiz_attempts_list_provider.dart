import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/quiz_attempts/quiz_attempt.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';

class QuizAttemptsListNotifier extends StateNotifier<AsyncValue<List<QuizAttempt>>> {
  final RestClient client;
  final String accessToken;
  final int quizId;

  QuizAttemptsListNotifier({
    required this.client,
    required this.accessToken,
    required this.quizId,
  }) : super(const AsyncValue.loading()) {
    fetchQuizAttempts(quizId);
  }

  Future<void> fetchQuizAttempts(int quizId) async {
    try {
      var quizAttempts = await client.getQuizAttemptsByQuiz(accessToken, quizId);
      state = AsyncValue.data(quizAttempts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final quizAttemptsListProvider = StateNotifierProvider.family<QuizAttemptsListNotifier, AsyncValue<List<QuizAttempt>>, int>((ref, quizId) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);

  return QuizAttemptsListNotifier(client: client, accessToken: token.accessToken, quizId: quizId);
});
