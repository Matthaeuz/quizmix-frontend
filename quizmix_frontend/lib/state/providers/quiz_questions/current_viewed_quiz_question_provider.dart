import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';

class CurrentViewedQuizQuestionNotifier
    extends StateNotifier<Map<String, dynamic>> {
  CurrentViewedQuizQuestionNotifier(Map<String, dynamic> question)
      : super(question);

  void updateCurrentViewedQuestion(Map<String, dynamic> newQuestion) {
    state = newQuestion;
  }
}

final currentViewedQuizQuestionProvider = StateNotifierProvider<
    CurrentViewedQuizQuestionNotifier, Map<String, dynamic>>((ref) {
  return CurrentViewedQuizQuestionNotifier(
      {"qnum": 0, "question": Question.base()});
});
