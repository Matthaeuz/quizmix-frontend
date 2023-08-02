import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/cat_pool_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewee_details_provider.dart';

class CATQuestionNotifier extends StateNotifier<AsyncValue<Question>> {
  final StateNotifierProviderRef<CATQuestionNotifier, AsyncValue<Question>> ref;
  final RestClient client;
  final String accessToken;
  final int revieweeId;

  CATQuestionNotifier({
    required this.ref,
    required this.client,
    required this.accessToken,
    required this.revieweeId,
  }) : super(const AsyncValue.loading()) {
    getQuestion();
  }

  Future<void> getQuestion() async {
    state = state;
  }

  Future<void> getNextQuestion(String category) async {
    try {
      final pool = ref.read(catPoolProvider).when(
            data: (data) {
              return data;
            },
            error: (err, st) {},
            loading: () {},
          );
      print('pool: $pool');
      if (pool != null) {
        var questionId = await client.selectItem(accessToken, {
          "reviewee": revieweeId,
          "item_pool": pool[category],
        });
        var question = await client.getQuestionById(accessToken, questionId);
        print(questionId);
        await ref
            .read(catPoolProvider.notifier)
            .removeItem(category, questionId);
        state = AsyncValue.data(question);
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final catQuestionProvider =
    StateNotifierProvider<CATQuestionNotifier, AsyncValue<Question>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final revieweeId = ref.read(revieweeProvider).when(
        data: (data) {
          return data.id;
        },
        error: (err, st) {},
        loading: () {},
      );

  return CATQuestionNotifier(
    ref: ref,
    client: client,
    accessToken: token.accessToken,
    revieweeId: revieweeId!,
  );
});
