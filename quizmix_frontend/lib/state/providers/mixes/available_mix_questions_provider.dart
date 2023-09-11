import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/mixes/mix.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_questions_provider.dart';

class AvailableMixQuestionsNotifier
    extends StateNotifier<AsyncValue<List<Question>>> {
  final StateNotifierProviderRef<AvailableMixQuestionsNotifier,
      AsyncValue<List<Question>>> ref;
  final RestClient client;
  final String accessToken;
  final Mix? mix;

  AvailableMixQuestionsNotifier({
    required this.ref,
    required this.client,
    required this.accessToken,
    required this.mix,
  }) : super(const AsyncValue.loading()) {
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      var questions = await client.getQuestions(accessToken);
      if (mix != null) {
        final currentQuestionIds =
            mix!.questions.map((question) => question.id).toList();
        questions.removeWhere(
            (question) => currentQuestionIds.contains(question.id));
      }
      state = AsyncValue.data(questions);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<Question?> removeQuestion(int index) async {
    try {
      List<Question>? newQuestions = state.when(
        data: (data) {
          return List.from(data);
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
      int insertIndex = newQuestions.indexWhere((q) => q.id > question.id);
      newQuestions.insert(insertIndex, question);
      state = AsyncValue.data(newQuestions);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> searchQuestions(Map<String, dynamic> filters) async {
    try {
      final currentQuestions = ref.read(currentMixQuestionsProvider);
      final currentQuestionsIds =
          currentQuestions.map((question) => question.id).toList();

      filters["exclude"] = currentQuestionsIds;
      var questions = await client.advancedSearch(accessToken, filters);
      state = AsyncValue.data(questions);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final availableMixQuestionsProvider = StateNotifierProvider<
    AvailableMixQuestionsNotifier, AsyncValue<List<Question>>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final mix = ref.watch(currentMixProvider);

  return AvailableMixQuestionsNotifier(
    ref: ref,
    client: client,
    accessToken: token.accessToken,
    mix: mix,
  );
});
