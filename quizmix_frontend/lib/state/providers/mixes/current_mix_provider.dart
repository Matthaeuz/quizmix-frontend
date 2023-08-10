import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';

class CurrentMixNotifier extends StateNotifier<Question?> {
  CurrentMixNotifier() : super(null);

  void updateCurrentMix(Question? newMix) {
    state = newMix;
  }
}

final currentMixProvider =
    StateNotifierProvider<CurrentMixNotifier, Question?>((ref) {
  return CurrentMixNotifier();
});
