import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/quiz_attempts/quiz_attempt.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';

class FirstQuizAttemptNotifier extends StateNotifier<AsyncValue<List<QuizAttempt>>> {
  final RestClient client;
  final String accessToken;

  FirstQuizAttemptNotifier({
    required this.client,
    required this.accessToken,
  }) : super(const AsyncValue.loading()) {
    fetchFirstQuizAttempts();
  }

  Future<void> fetchFirstQuizAttempts() async {
    try {
      var firstQuizAttempts = await client.getFirstAttemptsOfQuizzes(accessToken);
      state = AsyncValue.data(firstQuizAttempts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final firstQuizAttemptProvider = StateNotifierProvider<FirstQuizAttemptNotifier, AsyncValue<List<QuizAttempt>>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);

  return FirstQuizAttemptNotifier(client: client, accessToken: token.accessToken);
});
