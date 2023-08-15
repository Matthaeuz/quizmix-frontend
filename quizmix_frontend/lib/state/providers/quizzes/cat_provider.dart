import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_taken_quiz_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewee_details_provider.dart';

class CATNotifier extends StateNotifier<AsyncValue<Map<String, dynamic>>> {
  final StateNotifierProviderRef<CATNotifier, AsyncValue<Map<String, dynamic>>>
      ref;
  final RestClient client;
  final String accessToken;
  final int quizId;
  final int revieweeId;
  bool hasDataLoaded = false;

  CATNotifier({
    required this.ref,
    required this.client,
    required this.accessToken,
    required this.quizId,
    required this.revieweeId,
  }) : super(const AsyncValue.loading()) {
    initializeCAT();
  }

  String getRandomKey(Map<String, int> map) {
    if (map.isEmpty) {
      throw Exception('The map is empty');
    }
    List<String> keys = map.keys.toList();
    int randomIndex = Random().nextInt(keys.length);
    return keys[randomIndex];
  }

  Future<void> initializeCAT() async {
    try {
      // initialize specs
      final specs = await client.getQuizSpecs(accessToken, {"quiz": quizId});

      // initialize pool
      final Map<String, dynamic> pool = {};
      for (String key in specs.keys) {
        final questionsList =
            await client.getQuestionsByCategory(accessToken, key);
        List<int> questionIds =
            questionsList.map((question) => question.id).toList();
        pool[key] = questionIds;
      }

      // initialize first question
      String category = getRandomKey(specs);
      if (specs.containsKey(category)) {
        specs[category] = (specs[category] ?? 1) - 1;
      }
      if (specs[category] == 0) {
        specs.remove(category);
      }
      final questionId = await client.selectItem(accessToken, {
        "reviewee": revieweeId,
        "item_pool": pool[category],
      });
      if (pool.containsKey(category)) {
        pool[category].remove(questionId);
      }
      final question = await client.getQuestionById(accessToken, questionId);

      // compile state
      final initialState = {
        "specs": specs,
        "pool": pool,
        "question": question,
      };
      print(initialState);
      state = AsyncValue.data(initialState);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> getNextQuestion() async {
    try {
      final newState = Map<String, dynamic>.from(state.value!);

      // get new specs
      String category = getRandomKey(newState["specs"]);
      if (newState["specs"].containsKey(category)) {
        newState["specs"][category] = (newState["specs"][category] ?? 1) - 1;
      }
      if (newState["specs"][category] == 0) {
        newState["specs"].remove(category);
      }

      // get new question
      final questionId = await client.selectItem(accessToken, {
        "reviewee": revieweeId,
        "item_pool": newState["pool"][category],
      });

      // get new pool
      if (newState["pool"].containsKey(category)) {
        newState["pool"][category].remove(questionId);
      }
      newState["question"] =
          await client.getQuestionById(accessToken, questionId);

      // compile new state
      print(newState);
      state = AsyncValue.data(newState);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final catProvider =
    StateNotifierProvider<CATNotifier, AsyncValue<Map<String, dynamic>>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final quiz = ref.watch(currentTakenQuizProvider);
  final reviewee = ref.read(revieweeProvider).value;

  return CATNotifier(
    ref: ref,
    client: client,
    accessToken: token.accessToken,
    quizId: quiz.id,
    revieweeId: reviewee!.id,
  );
});
