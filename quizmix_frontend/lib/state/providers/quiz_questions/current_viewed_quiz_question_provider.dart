import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';

class CurrentViewedQuizQuestionNotifier extends StateNotifier<Question> {
  CurrentViewedQuizQuestionNotifier(Question question) : super(question);

  void updateCurrentViewedQuestion(Question newQuestion) {
    state = newQuestion;
  }
}

final currentViewedQuizQuestionProvider =
    StateNotifierProvider<CurrentViewedQuizQuestionNotifier, Question?>((ref) {
  return CurrentViewedQuizQuestionNotifier(Question.base());
});
