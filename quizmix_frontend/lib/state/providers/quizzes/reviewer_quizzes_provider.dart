import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/models/quizzes/tos.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewers/reviewer_details_provider.dart';

class ReviewerQuizzesNotifier extends StateNotifier<AsyncValue<List<Quiz>>> {
  final RestClient client;
  final String accessToken;
  final int madeBy;

  ReviewerQuizzesNotifier({
    required this.client,
    required this.accessToken,
    required this.madeBy,
  }) : super(const AsyncValue.loading()) {
    fetchQuizzes();
  }

  Future<void> fetchQuizzes() async {
    try {
      var quizzes = await client.getMadeByQuizzes(accessToken, madeBy);
      state = AsyncValue.data(quizzes);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addQuiz(TOS tos) async {
    try {
      await client.createQuizFromTOS(accessToken, tos);
      await fetchQuizzes();  // Refetch quizzes after adding.
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final reviewerQuizzesProvider = StateNotifierProvider<ReviewerQuizzesNotifier, AsyncValue<List<Quiz>>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final madeBy = ref.watch(reviewerProvider).id;

  return ReviewerQuizzesNotifier(client: client, accessToken: token.accessToken, madeBy: madeBy);
});
