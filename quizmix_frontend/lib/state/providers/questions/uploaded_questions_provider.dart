import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';

class UploadedQuestionsNotiifier extends StateNotifier<List<Question>> {
  UploadedQuestionsNotiifier() : super([]);

  void updateUploadedQuestions(List<Question> newQuestions) {
    state = newQuestions;
  }
}

final uploadedQuestionsProvider =
    StateNotifierProvider<UploadedQuestionsNotiifier, List<Question>>((ref) {
  return UploadedQuestionsNotiifier();
});
