import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/mixes/mix.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewee_details_provider.dart';

class RevieweeMixesNotifier extends StateNotifier<AsyncValue<List<Mix>>> {
  final RestClient client;
  final String accessToken;
  final int madeBy;

  RevieweeMixesNotifier({
    required this.client,
    required this.accessToken,
    required this.madeBy,
  }) : super(const AsyncValue.loading()) {
    fetchMixes();
  }

  Future<void> fetchMixes() async {
    try {
      var mixes = await client.getMadeByMixes(accessToken, madeBy);
      state = AsyncValue.data(mixes);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final revieweeMixesProvider =
    StateNotifierProvider<RevieweeMixesNotifier, AsyncValue<List<Mix>>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final madeBy = ref.read(revieweeProvider).when(
        data: (data) {
          return data.id;
        },
        error: (err, st) {},
        loading: () {},
      );

  return RevieweeMixesNotifier(
    client: client,
    accessToken: token.accessToken,
    madeBy: madeBy!,
  );
});
