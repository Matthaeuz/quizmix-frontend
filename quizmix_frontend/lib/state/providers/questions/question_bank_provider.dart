import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/api/utils/multipart_form_handlers/upload_pdf.helper.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';

class QuestionBankNotifier extends StateNotifier<AsyncValue<List<Question>>> {
  final RestClient client;
  final String accessToken;
  late List<Question> allQuestions;

  QuestionBankNotifier({
    required this.client,
    required this.accessToken,
  }) : super(const AsyncValue.loading()) {
    fetchQuestions();
  }

  Future<void> fetchQuestions() async {
    try {
      var questions = await client.getQuestions(accessToken);
      allQuestions = questions;
      state = AsyncValue.data(questions);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void textSearchQuestions(String value) {
    if (value.isEmpty) {
      state = AsyncValue.data(allQuestions);
    } else {
      final searchResult = allQuestions
          .where((question) =>
              question.question.toLowerCase().contains(value.toLowerCase()))
          .toList();
      state = AsyncValue.data(searchResult);
    }
  }

  Future<void> searchQuestions(Map<String, dynamic> filters) async {
    try {
      var questions = await client.advancedSearch(accessToken, filters);
      allQuestions = questions;
      state = AsyncValue.data(questions);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addQuestionsFromPdf(
      PlatformFile aFile, PlatformFile qFile, WidgetRef ref) async {
    try {
      await createQuestionsFromPdf(aFile, qFile, ref);
      await fetchQuestions();
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final questionBankProvider =
    StateNotifierProvider<QuestionBankNotifier, AsyncValue<List<Question>>>(
        (ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);

  return QuestionBankNotifier(client: client, accessToken: token.accessToken);
});
