import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';

class CurrentQuizViewedNotifier extends StateNotifier<Quiz> {
  CurrentQuizViewedNotifier(Quiz quiz) : super(quiz);

  void updateCurrentQuiz(Quiz newQuiz) {
    state = newQuiz;
  }
}

final currentQuizViewedProvider =
    StateNotifierProvider<CurrentQuizViewedNotifier, Quiz>((ref) {
  return CurrentQuizViewedNotifier(Quiz.base());
});
