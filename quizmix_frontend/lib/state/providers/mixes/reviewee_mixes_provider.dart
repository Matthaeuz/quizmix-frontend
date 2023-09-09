import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/mixes/mix.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';

class RevieweeMixesNotifier extends StateNotifier<AsyncValue<List<Mix>>> {
  final RestClient client;
  final String accessToken;
  final int madeBy;
  late List<Mix> allMixes;

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
      allMixes = mixes.reversed.toList();
      state = AsyncValue.data(allMixes);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void searchMixes(String value) {
    if (value.isEmpty) {
      state = AsyncValue.data(allMixes);
    } else {
      final searchResult = allMixes
          .where((mix) => mix.title.toLowerCase().contains(value.toLowerCase()))
          .toList();
      state = AsyncValue.data(searchResult);
    }
  }
}

final revieweeMixesProvider =
    StateNotifierProvider<RevieweeMixesNotifier, AsyncValue<List<Mix>>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final madeBy = ref.read(userProvider).id;

  return RevieweeMixesNotifier(
    client: client,
    accessToken: token.accessToken,
    madeBy: madeBy,
  );
});
