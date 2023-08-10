import 'package:hooks_riverpod/hooks_riverpod.dart';

final initialFilters = {
  "text": "",
  "categories": [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ],
  "discrimination": [true, true, true, true, true],
  "difficulty": [true, true, true, true, true]
};

class MixQuestionSearchFilterNotifier
    extends StateNotifier<Map<String, dynamic>> {
  MixQuestionSearchFilterNotifier() : super(initialFilters);

  void initializeFilters() {
    state = initialFilters;
  }

  void updateFiltersText(String newText) {
    Map<String, dynamic> newFilters = Map.from(state);
    newFilters["text"] = newText;
    state = newFilters;
  }

  void updateFiltersList(String key, int index, bool newBool) {
    Map<String, dynamic> newFilters = Map.from(state);
    newFilters[key][index] = newBool;
    state = newFilters;
  }

  void updateFilters(Map<String, dynamic> newFilters) {
    state = newFilters;
  }
}

final mixQuestionSearchFilterProvider = StateNotifierProvider<
    MixQuestionSearchFilterNotifier, Map<String, dynamic>>((ref) {
  return MixQuestionSearchFilterNotifier();
});
