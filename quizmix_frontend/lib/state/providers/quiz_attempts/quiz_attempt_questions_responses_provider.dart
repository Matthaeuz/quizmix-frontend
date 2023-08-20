import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/quiz_attempts/quiz_attempt_questions_responses.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/current_quiz_attempted_provider.dart';

class QuizAttemptQuestionsResponsesNotifier
    extends StateNotifier<AsyncValue<QuizAttemptQuestionsResponses>> {
  final RestClient client;
  final String accessToken;
  final int attemptId;

  QuizAttemptQuestionsResponsesNotifier({
    required this.client,
    required this.accessToken,
    required this.attemptId,
  }) : super(const AsyncValue.loading()) {
    fetchQuizAttemptQuestionsResponses();
  }

  Future<void> fetchQuizAttemptQuestionsResponses() async {
    try {
      var quizAttemptQuestionsResponses = await client
          .getQuizAttemptQuestionsResponses(
              accessToken, {"attemptId": attemptId});
      state = AsyncValue.data(quizAttemptQuestionsResponses);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final quizAttemptQuestionsResponsesProvider = StateNotifierProvider<
    QuizAttemptQuestionsResponsesNotifier,
    AsyncValue<QuizAttemptQuestionsResponses>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final quizAttempt = ref.watch(currentQuizAttemptedProvider);

  return QuizAttemptQuestionsResponsesNotifier(
    client: client,
    accessToken: token.accessToken,
    attemptId: quizAttempt.id,
  );
});
