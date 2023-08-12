import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/mixes/mix.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_provider.dart';

class CurrentMixQuestionsNotifier
    extends StateNotifier<AsyncValue<List<Question>>> {
  final RestClient client;
  final String accessToken;
  final Mix? mix;

  CurrentMixQuestionsNotifier({
    required this.client,
    required this.accessToken,
    required this.mix,
  }) : super(const AsyncValue.loading()) {
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      if (mix == null) {
        state = const AsyncValue.data([]);
      } else {
        state = AsyncValue.data(List.from(mix!.questions));
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<Question?> removeQuestion(int index) async {
    try {
      List<Question>? newQuestions = state.when(
        data: (data) {
          return data;
        },
        error: (err, st) {
          return null;
        },
        loading: () {
          return null;
        },
      );
      Question removedQuestion = newQuestions!.removeAt(index);
      state = AsyncValue.data(newQuestions);
      return removedQuestion;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  Future<void> addQuestion(Question question) async {
    try {
      List<Question> newQuestions = state.when(
        data: (data) {
          return List.from(data);
        },
        error: (err, st) {
          return [];
        },
        loading: () {
          return [];
        },
      );
      newQuestions.add(question);
      state = AsyncValue.data(newQuestions);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final currentMixQuestionsProvider = StateNotifierProvider<
    CurrentMixQuestionsNotifier, AsyncValue<List<Question>>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final mix = ref.watch(currentMixProvider);

  return CurrentMixQuestionsNotifier(
    client: client,
    accessToken: token.accessToken,
    mix: mix,
  );
});
