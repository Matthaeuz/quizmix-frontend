import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/quiz_attempts/quiz_attempt.dart';

class CurrentQuizAttemptedNotifier extends StateNotifier<QuizAttempt> {
  CurrentQuizAttemptedNotifier(QuizAttempt quizAttempt) : super(quizAttempt);

  void updateCurrentQuizAttempted(QuizAttempt newQuizAttempt) {
    state = newQuizAttempt;
  }
}

final currentQuizAttemptedProvider = StateNotifierProvider<CurrentQuizAttemptedNotifier, QuizAttempt>((ref) {
  return CurrentQuizAttemptedNotifier(QuizAttempt.base());
});