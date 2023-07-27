import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';

class CurrentQuestionNotifier extends StateNotifier<Question?> {
  CurrentQuestionNotifier() : super(null);

  void updateCurrentQuestion(Question newQuestion) {
    state = newQuestion;
  }
}

final currentQuestionProvider =
    StateNotifierProvider<CurrentQuestionNotifier, Question?>((ref) {
  return CurrentQuestionNotifier();
});
