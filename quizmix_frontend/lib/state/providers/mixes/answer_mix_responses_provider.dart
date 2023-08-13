import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_provider.dart';

class AnswerMixResponsesNotifier extends StateNotifier<List<String>> {
  AnswerMixResponsesNotifier({required this.ref}) : super([]);

  final StateNotifierProviderRef<AnswerMixResponsesNotifier, List<String>> ref;

  void initialize() {
    final questions = ref.watch(currentMixProvider)!.questions;
    final initialResponses = List.generate(questions.length, (_) => '');
    state = initialResponses;
  }

  void updateResponses(int index, String newResponse) {
    state[index] = newResponse;
  }
}

final answerMixResponsesProvider =
    StateNotifierProvider<AnswerMixResponsesNotifier, List<String>>((ref) {
  return AnswerMixResponsesNotifier(ref: ref);
});
