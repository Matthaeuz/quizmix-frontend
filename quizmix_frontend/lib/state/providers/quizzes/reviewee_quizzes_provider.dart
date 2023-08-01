import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewee_details_provider.dart';

class RevieweeQuizzesNotifier extends StateNotifier<AsyncValue<List<Quiz>>> {
  final RestClient client;
  final String accessToken;
  final int madeBy;

  RevieweeQuizzesNotifier({
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
      if (e is DioException && e.response?.statusCode == 400) {
        state = const AsyncValue.data([]);
      } else {
        state = AsyncValue.error(e, st);
      }
    }
  }
}

final revieweeQuizzesProvider =
    StateNotifierProvider<RevieweeQuizzesNotifier, AsyncValue<List<Quiz>>>(
        (ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final madeBy = ref.watch(revieweeProvider).when(
        data: (data) {
          return data.belongsTo?.id;
        },
        error: (err, st) {},
        loading: () {},
      );

  return RevieweeQuizzesNotifier(
      client: client, accessToken: token.accessToken, madeBy: madeBy ?? 0);
});
