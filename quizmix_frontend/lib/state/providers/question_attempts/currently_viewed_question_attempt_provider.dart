import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';

class CurrentViewedQuestionAttemptNotifier
    extends StateNotifier<Map<String, dynamic>> {
  CurrentViewedQuestionAttemptNotifier(Map<String, dynamic> question)
      : super(question);

  void updateCurrentViewedQuestion(Map<String, dynamic> newQuestion) {
    state = newQuestion;
  }
}

final currentViewedQuestionAttemptProvider = StateNotifierProvider<
    CurrentViewedQuestionAttemptNotifier, Map<String, dynamic>>((ref) {
  return CurrentViewedQuestionAttemptNotifier(
      {"qnum": 0, "question": Question.base()});
});
