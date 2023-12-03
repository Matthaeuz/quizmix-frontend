import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/quiz_attempts/quiz_attempt.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_viewed_quiz_provider.dart';

class CurrentQuizListAttemptsNotifier
    extends StateNotifier<AsyncValue<List<QuizAttempt>>> {
  final RestClient client;
  final String accessToken;
  final Quiz currentQuiz;

  CurrentQuizListAttemptsNotifier({
    required this.client,
    required this.accessToken,
    required this.currentQuiz,
  }) : super(const AsyncValue.loading()) {
    fetchCurrentQuizListAttempts();
  }

  Future<void> fetchCurrentQuizListAttempts() async {
    try {
      var currentQuizListAttempts =
          await client.getQuizAttemptsByQuiz(accessToken, currentQuiz.id);
      currentQuizListAttempts.sort((a, b) => a.timeStarted.compareTo(b.timeStarted));
      state = AsyncValue.data(currentQuizListAttempts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  // use this for when you need to get the list without the AsyncValue data type
  List<QuizAttempt> quizAttempts() {
    return state.when(
        data: (quizAttempts) => quizAttempts,
        loading: () => [],
        error: (error, stackTrace) => []);
  }
}

final currentQuizListAttemptsProvider = StateNotifierProvider<
    CurrentQuizListAttemptsNotifier, AsyncValue<List<QuizAttempt>>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final currentQuiz = ref.watch(currentQuizViewedProvider);

  return CurrentQuizListAttemptsNotifier(
    client: client,
    accessToken: token.accessToken,
    currentQuiz: currentQuiz,
  );
});
