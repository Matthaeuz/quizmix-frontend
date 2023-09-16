import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ModalState {
  none,
  forgotPassword,
  advancedSearch,
  viewQuestion,
  mixAdvancedSearch,
  preparingQuiz,
  viewRevieweeQuizAttempts,
}

class ModalStateNotifier extends StateNotifier<ModalState> {
  ModalStateNotifier(ModalState initModalState) : super(initModalState);

  void updateModalState(ModalState newModalState) {
    state = newModalState;
  }
}

final modalStateProvider =
    StateNotifierProvider<ModalStateNotifier, ModalState>((ref) {
  return ModalStateNotifier(ModalState.none);
});
