import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/question_attempts/question_attempt.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_viewed_quiz_provider.dart';

class AllQuestionAttemptsNotifier extends StateNotifier<AsyncValue<Map<String, List<QuestionAttempt>>>> {
  final RestClient client;
  final String accessToken;
  final Quiz currentQuiz;

  AllQuestionAttemptsNotifier({
    required this.client,
    required this.accessToken,
    required this.currentQuiz,
  }) : super(const AsyncValue.loading()) {
    fetchAllQuestionAttempts();
  }

  Future<void> fetchAllQuestionAttempts() async {
    try {
      var currentQuizQuestionAttempts =
          await client.getQuestionAttemptsByQuiz(accessToken, currentQuiz.id);

      Map<String, List<QuestionAttempt>> attemptsByIndividual = {};
      for (var attempt in currentQuizQuestionAttempts) {
        var key = attempt.attempt.attemptedBy.id.toString(); 
        attemptsByIndividual[key] = (attemptsByIndividual[key] ?? [])..add(attempt);
      }

      state = AsyncValue.data(attemptsByIndividual);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final allQuestionAttemptsProvider = StateNotifierProvider<
    AllQuestionAttemptsNotifier, AsyncValue<Map<String, List<QuestionAttempt>>>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final currentQuiz = ref.watch(currentQuizViewedProvider);

  return AllQuestionAttemptsNotifier(
    client: client,
    accessToken: token.accessToken,
    currentQuiz: currentQuiz,
  );
});
