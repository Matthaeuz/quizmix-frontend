import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';

// class CurrentTakenQuizNotifier extends StateNotifier<Quiz> {
//   CurrentTakenQuizNotifier(Quiz quiz) : super(quiz);

//   void updateCurrentQuiz(Quiz newQuiz) {
//     state = newQuiz;
//   }
// }

class CurrentTakenQuizNotifier extends StateNotifier<Quiz> {
  int score = 0; // This is your new score variable

  CurrentTakenQuizNotifier(Quiz quiz) : super(quiz);

  void updateCurrentQuiz(Quiz newQuiz) {
    state = newQuiz;
  }

  void updateScore(int newScore) {
    score = newScore;
  }
}


final currentTakenQuizProvider =
    StateNotifierProvider<CurrentTakenQuizNotifier, Quiz>((ref) {
  return CurrentTakenQuizNotifier(Quiz.base());
});
