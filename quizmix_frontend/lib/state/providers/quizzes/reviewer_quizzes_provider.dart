import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewers/reviewer_details_provider.dart';

final reviewerQuizzesProvider = FutureProvider.autoDispose<List<Quiz>>((ref) async {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final madeBy = ref.watch(reviewerProvider).id;

  return await client.getMadeByQuizzes(token.accessToken, madeBy);
});