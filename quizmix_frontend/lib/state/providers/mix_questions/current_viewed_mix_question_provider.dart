import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';

class CurrentViewedMixQuestionNotifier
    extends StateNotifier<Map<String, dynamic>> {
  CurrentViewedMixQuestionNotifier(Map<String, dynamic> question)
      : super(question);

  void updateCurrentViewedQuestion(Map<String, dynamic> newQuestion) {
    state = newQuestion;
  }
}

final currentViewedMixQuestionProvider = StateNotifierProvider<
    CurrentViewedMixQuestionNotifier, Map<String, dynamic>>((ref) {
  return CurrentViewedMixQuestionNotifier(
      {"qnum": 0, "question": Question.base()});
});
