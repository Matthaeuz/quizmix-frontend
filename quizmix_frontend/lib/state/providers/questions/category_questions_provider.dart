import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';

final categoryQuestionsProvider = FutureProvider.family.autoDispose<List<Question>, String>((ref, category) async {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);

  return await client.getQuestionsByCategory(token.accessToken, category);
});

