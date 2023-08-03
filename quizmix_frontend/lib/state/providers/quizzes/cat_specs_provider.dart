import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/cat_pool_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/cat_question_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_taken_quiz_provider.dart';

class CATSpecsNotifier extends StateNotifier<AsyncValue<Map<String, int>>> {
  final StateNotifierProviderRef<CATSpecsNotifier, AsyncValue<Map<String, int>>>
      ref;
  final RestClient client;
  final String accessToken;
  final int quizId;
  bool hasDataLoaded = false;

  CATSpecsNotifier({
    required this.ref,
    required this.client,
    required this.accessToken,
    required this.quizId,
  }) : super(const AsyncValue.loading()) {
    getSpecs();
  }

  String getRandomKey(Map<String, int>? map) {
    if (map == null || map.isEmpty) {
      throw Exception('The map is empty');
    }

    // Get the keys from the map
    List<String> keys = map.keys.toList();

    // Generate a random index within the range of the keys list
    int randomIndex = Random().nextInt(keys.length);

    // Return the random key
    return keys[randomIndex];
  }

  Future<void> getSpecs() async {
  if (!hasDataLoaded) {
    try {
      var specs = await client.getQuizSpecs(accessToken, {"quiz": quizId});
      state = AsyncValue.data(specs);
      print('firstspecs: $specs');
      hasDataLoaded = true;

      // get pool firsts before loading specs
      await ref.read(catPoolProvider.notifier).getPool();

      await updateSpecs(); // move this after the pool is populated
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

  Future<void> updateSpecs() async {
    try {
      Map<String, int>? newMap = state.when(
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

      String category = getRandomKey(newMap);
      if (newMap!.containsKey(category)) {
        newMap[category] = (newMap[category] ?? 1) - 1;
      }
      if (newMap[category] == 0) {
        newMap.remove(category);
      }
      print('newmap: $newMap');

      await ref.read(catPoolProvider.notifier).getPool();
      await ref.read(catQuestionProvider.notifier).getNextQuestion(category);

      state = AsyncValue.data(newMap);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final catSpecsProvider =
    StateNotifierProvider<CATSpecsNotifier, AsyncValue<Map<String, int>>>(
        (ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final quiz = ref.watch(currentTakenQuizProvider);

  return CATSpecsNotifier(
    ref: ref,
    client: client,
    accessToken: token.accessToken,
    quizId: quiz.id,
  );
});
