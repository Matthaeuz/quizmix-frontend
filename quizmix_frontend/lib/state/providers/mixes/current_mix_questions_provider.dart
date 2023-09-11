import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/mixes/mix.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_provider.dart';

class CurrentMixQuestionsNotifier extends StateNotifier<List<Question>> {
  final RestClient client;
  final String accessToken;
  final Mix? mix;

  CurrentMixQuestionsNotifier({
    required this.client,
    required this.accessToken,
    required this.mix,
  }) : super([]);

  void fetchQuestions() {
    if (mix == null) {
      state = [];
    } else {
      state = mix!.questions;
    }
  }

  Question removeQuestion(int index) {
    List<Question> newQuestions = List.from(state);
    Question removedQuestion = newQuestions.removeAt(index);
    state = newQuestions;
    return removedQuestion;
  }

  void addQuestion(Question question) {
    List<Question> newQuestions = List.from(state);
    newQuestions.add(question);
    state = newQuestions;
  }
}

final currentMixQuestionsProvider =
    StateNotifierProvider<CurrentMixQuestionsNotifier, List<Question>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final mix = ref.watch(currentMixProvider);

  return CurrentMixQuestionsNotifier(
    client: client,
    accessToken: token.accessToken,
    mix: mix,
  );
});
