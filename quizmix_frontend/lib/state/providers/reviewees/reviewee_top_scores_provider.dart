import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/reviewees/top_scores.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewee_details_provider.dart';

class RevieweeTopScoresNotifier extends StateNotifier<AsyncValue<TopScores>> {
  final RestClient client;
  final String accessToken;
  final int revieweeId;

  RevieweeTopScoresNotifier({
    required this.client,
    required this.accessToken,
    required this.revieweeId,
  }) : super(const AsyncValue.loading()) {
    fetchRevieweeTopScores(revieweeId);
  }

  Future<void> fetchRevieweeTopScores(int revieweeId) async {
    try {
      var topScores = await client
          .getRevieweeTopScores(accessToken, {"reviewee": revieweeId});
      state = AsyncValue.data(topScores);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final revieweeTopScoresProvider =
    StateNotifierProvider<RevieweeTopScoresNotifier, AsyncValue<TopScores>>(
        (ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final revieweeId = ref.read(revieweeProvider).when(
        data: (data) {
          return data.id;
        },
        error: (err, st) {},
        loading: () {},
      );

  return RevieweeTopScoresNotifier(
    client: client,
    accessToken: token.accessToken,
    revieweeId: revieweeId!,
  );
});
