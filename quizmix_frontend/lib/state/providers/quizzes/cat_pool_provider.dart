import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/cat_specs_provider.dart';

class CATPoolNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final StateNotifierProviderRef<CATPoolNotifier,
      AsyncValue<Map<String, dynamic>>> ref;
  final RestClient client;
  final String accessToken;
  bool hasDataLoaded = false;

  CATPoolNotifier({
    required this.ref,
    required this.client,
    required this.accessToken,
  }) : super(const AsyncValue.loading()) {
    getPool();
  }

  Future<void> getPool() async {
    if (!hasDataLoaded) {
      try {
        Map<String, dynamic> pool = {};
        final specs = ref.read(catSpecsProvider).when(
              data: (data) {
                return data;
              },
              error: (err, st) {},
              loading: () {},
            );
        print('readspecs: $specs');
        if (specs != null) {
          for (var key in specs.keys) {
            final questionsList =
                await client.getQuestionsByCategory(accessToken, key);
            List<int> questionIds =
                questionsList.map((question) => question.id).toList();
            pool[key] = questionIds;
            // pool[key] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
          }
          hasDataLoaded = true;
        }
        print('firstpool: $pool');
        state = AsyncValue.data(pool);
      } catch (e, st) {
        state = AsyncValue.error(e, st);
      }
    }
    state = state;
  }

  Future<void> removeItem(String category, int questionId) async {
    try {
      Map<String, dynamic>? newMap = state.when(
        data: (data) {
          return data;
        },
        error: (err, st) {
          return null;
        },
        loading: () {
          return null;
        },
      );
      if (newMap!.containsKey(category)) {
        newMap[category].remove(questionId);
      }
      state = AsyncValue.data(newMap);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final catPoolProvider =
    StateNotifierProvider<CATPoolNotifier, AsyncValue<Map<String, dynamic>>>(
        (ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);

  return CATPoolNotifier(
    ref: ref,
    client: client,
    accessToken: token.accessToken,
  );
});
