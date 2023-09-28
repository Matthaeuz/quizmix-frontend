import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/users/user.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';

class UnassignedRevieweesNotifier
    extends StateNotifier<AsyncValue<List<User>>> {
  final RestClient client;
  final String accessToken;

  UnassignedRevieweesNotifier({
    required this.client,
    required this.accessToken,
  }) : super(const AsyncValue.loading()) {
    fetchUnassignedReviewees();
  }

  void setLoading() {
    state = const AsyncValue.loading();
  }

  Future<void> fetchUnassignedReviewees() async {
    try {
      final revieweeUAVs = await client.getUnassignedReviewees(accessToken);
      final reviewees =
          revieweeUAVs.map((revieweeUAV) => revieweeUAV.user).toList();
      state = AsyncValue.data(reviewees);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final unassignedRevieweesProvider =
    StateNotifierProvider<UnassignedRevieweesNotifier, AsyncValue<List<User>>>(
        (ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);

  return UnassignedRevieweesNotifier(
      client: client, accessToken: token.accessToken);
});
