import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/reviewees/reviewee.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';

class RevieweeDetailsNotifier extends StateNotifier<AsyncValue<Reviewee>> {
  final RestClient client;
  final String accessToken;
  final int userId;

  RevieweeDetailsNotifier({
    required this.client,
    required this.accessToken,
    required this.userId,
  }) : super(const AsyncValue.loading()) {
    fetchReviewee(userId);
  }

  Future<void> fetchReviewee(int userId) async {
    try {
      var reviewee = await client.getRevieweeByUserId(accessToken, userId);
      state = AsyncValue.data(reviewee[0]);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateReviewee(WidgetRef ref, Map<String, int> resp) async {
    final user = ref.watch(userProvider);
    try {
      await client.updateScoresAndParams(accessToken, resp);
      await fetchReviewee(user.id);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final revieweeProvider =
    StateNotifierProvider<RevieweeDetailsNotifier, AsyncValue<Reviewee>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final user = ref.watch(userProvider);

  return RevieweeDetailsNotifier(
    client: client,
    accessToken: token.accessToken,
    userId: user.id,
  );
});
