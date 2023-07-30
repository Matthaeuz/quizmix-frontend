import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';

class CurrentEditedQuestionNotifier extends StateNotifier<Question?> {
  CurrentEditedQuestionNotifier() : super(null);

  void updateCurrentEditedQuestion(Question newQuestion) {
    state = newQuestion;
  }
}

final currentEditedQuestionProvider =
    StateNotifierProvider<CurrentEditedQuestionNotifier, Question?>((ref) {
  return CurrentEditedQuestionNotifier();
});
