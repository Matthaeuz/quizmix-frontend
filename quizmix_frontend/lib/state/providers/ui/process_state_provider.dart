import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ProcessState { loading, done }

class ProcessStateNotifier extends StateNotifier<ProcessState> {
  ProcessStateNotifier(ProcessState initProcessState) : super(initProcessState);

  void updateProcessState(ProcessState newProcessState) {
    state = newProcessState;
  }
}

final processStateProvider =
    StateNotifierProvider<ProcessStateNotifier, ProcessState>((ref) {
  return ProcessStateNotifier(ProcessState.done);
});
