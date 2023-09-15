import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';

class CategoryQuestionsNotifier
    extends StateNotifier<AsyncValue<List<Question>>> {
  final RestClient client;
  final String accessToken;
  final int category;

  CategoryQuestionsNotifier({
    required this.client,
    required this.accessToken,
    required this.category,
  }) : super(const AsyncValue.loading()) {
    fetchQuestionsByCategory();
  }

  Future<void> fetchQuestionsByCategory() async {
    try {
      var questions =
          await client.getQuestionsByCategory(accessToken, category);
      state = AsyncValue.data(questions);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final categoryQuestionsProvider = StateNotifierProvider.family
    .autoDispose<CategoryQuestionsNotifier, AsyncValue<List<Question>>, int>(
        (ref, category) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);

  return CategoryQuestionsNotifier(
      client: client, accessToken: token.accessToken, category: category);
});
