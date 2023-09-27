import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_viewed_quiz_provider.dart';

class CurrentQuizQuestionsNotifier extends StateNotifier<List<Question>> {
  final RestClient client;
  final String accessToken;
  final Quiz? quiz;

  CurrentQuizQuestionsNotifier({
    required this.client,
    required this.accessToken,
    required this.quiz,
  }) : super([]);

  void fetchQuestions() {
    if (quiz == null) {
      state = [];
    } else {
      state = quiz!.questions;
    }
  }

  Question removeQuestion(int index) {
    List<Question> newQuestions = List.from(state);
    Question removedQuestion = newQuestions.removeAt(index);
    state = newQuestions;
    return removedQuestion;
  }

  void addQuestion(Question question) {
    List<Question> newQuestions = List.from(state);
    newQuestions.add(question);
    state = newQuestions;
  }
}

final currentQuizQuestionsProvider =
    StateNotifierProvider<CurrentQuizQuestionsNotifier, List<Question>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final quiz = ref.watch(currentQuizViewedProvider);

  return CurrentQuizQuestionsNotifier(
    client: client,
    accessToken: token.accessToken,
    quiz: quiz,
  );
});
