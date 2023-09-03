import 'package:flutter_riverpod/flutter_riverpod.dart';

enum TabState { revieweeQuizzes, revieweeMixes, revieweeQuestionBank }

class TabStateNotifier extends StateNotifier<TabState> {
  TabStateNotifier(TabState initTabState) : super(initTabState);

  void updateTabState(TabState newTabState) {
    state = newTabState;
  }
}

final tabStateProvider =
    StateNotifierProvider<TabStateNotifier, TabState>((ref) {
  return TabStateNotifier(TabState.revieweeQuizzes);
});
