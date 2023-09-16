import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/question_attempts/question_attempt.dart';

class CurrentViewedQuestionAttemptNotifier
    extends StateNotifier<Map<String, dynamic>> {
  CurrentViewedQuestionAttemptNotifier(Map<String, dynamic> questionAttempt)
      : super(questionAttempt);

  void updateCurrentViewedQuestionAttempt(
      Map<String, dynamic> newQuestionAttempt) {
    state = newQuestionAttempt;
  }
}

final currentViewedQuestionAttemptProvider = StateNotifierProvider<
    CurrentViewedQuestionAttemptNotifier, Map<String, dynamic>>((ref) {
  return CurrentViewedQuestionAttemptNotifier(
      {"qanum": 0, "questionAttempt": QuestionAttempt.base()});
});
