import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/mixes/mix.dart';

class CurrentMixNotifier extends StateNotifier<Mix?> {
  CurrentMixNotifier() : super(null);

  void updateCurrentMix(Mix? newMix) {
    state = newMix;
  }
}

final currentMixProvider =
    StateNotifierProvider<CurrentMixNotifier, Mix?>((ref) {
  return CurrentMixNotifier();
});
