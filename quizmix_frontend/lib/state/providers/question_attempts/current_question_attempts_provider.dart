import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/question_attempts/question_attempt.dart';

class CurrentQuestionAttemptsNotifier
    extends StateNotifier<List<QuestionAttempt>> {
  CurrentQuestionAttemptsNotifier(List<QuestionAttempt> questionAttempts)
      : super(questionAttempts);

  void updateCurrentQuestionAttempts(
      List<QuestionAttempt> newQuestionAttempts) {
    state = newQuestionAttempts;
  }
}

final currentQuestionAttemptsProvider = StateNotifierProvider<
    CurrentQuestionAttemptsNotifier, List<QuestionAttempt>>((ref) {
  return CurrentQuestionAttemptsNotifier([]);
});
