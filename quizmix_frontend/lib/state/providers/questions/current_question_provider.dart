import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';

class CurrentQuestionNotifier extends StateNotifier<Question?> {
  CurrentQuestionNotifier() : super(null);

  void updateCurrentQuestion(Question newQuestion) {
    state = Question(
      id: newQuestion.id,
      question: newQuestion.question,
      image: newQuestion.image,
      answer: newQuestion.answer,
      choices: newQuestion.choices,
      category: newQuestion.category,
      solution: newQuestion.solution,
      parameters: newQuestion.parameters,
      responses: newQuestion.responses,
      thetas: newQuestion.thetas,
    );
  }
}

final currentQuestionProvider =
    StateNotifierProvider<CurrentQuestionNotifier, Question?>((ref) {
  return CurrentQuestionNotifier();
});
