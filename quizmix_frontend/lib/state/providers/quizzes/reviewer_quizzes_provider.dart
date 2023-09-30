import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/models/quizzes/tos.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';

class ReviewerQuizzesNotifier extends StateNotifier<AsyncValue<List<Quiz>>> {
  final RestClient client;
  final String accessToken;
  final int reviewerId;
  List<Quiz> allQuizzes = [];

  ReviewerQuizzesNotifier({
    required this.client,
    required this.accessToken,
    required this.reviewerId,
  }) : super(const AsyncValue.loading()) {
    fetchQuizzes();
  }

  Future<void> fetchQuizzes() async {
    try {
      final quizzes = await client.getMadeByQuizzes(accessToken, reviewerId);
      quizzes.sort((a, b) => b.createdOn.compareTo(a.createdOn));
      allQuizzes = quizzes;
      state = AsyncValue.data(quizzes);
    } catch (e, st) {
      if (e is DioException && e.response?.statusCode == 400) {
        state = const AsyncValue.data([]);
      } else {
        state = AsyncValue.error(e, st);
      }
    }
  }

  Future<void> addQuiz(TOS tos) async {
    try {
      await client.createQuizFromTOS(accessToken, tos);
      fetchQuizzes(); // Refetch quizzes after adding.
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void searchQuizzes(String value) {
    if (value.isEmpty) {
      state = AsyncValue.data(allQuizzes);
    } else {
      final searchResult = allQuizzes
          .where(
              (quiz) => quiz.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
      state = AsyncValue.data(searchResult);
    }
  }
}

final reviewerQuizzesProvider =
    StateNotifierProvider<ReviewerQuizzesNotifier, AsyncValue<List<Quiz>>>(
        (ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final reviewerId = ref.watch(userProvider).id;

  return ReviewerQuizzesNotifier(
      client: client, accessToken: token.accessToken, reviewerId: reviewerId);
});
