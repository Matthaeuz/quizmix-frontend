import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/providers/categories/category_provider.dart';

class MixQuestionSearchFilterNotifier
    extends StateNotifier<Map<String, dynamic>> {
  Map<String, dynamic> initialFilters;
  List<String> categoryNames;

  MixQuestionSearchFilterNotifier({
    required this.initialFilters,
    required this.categoryNames,
  }) : super(initialFilters);

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
  final categories = ref.watch(categoryProvider);
  final initialFilters = {
    "text": "",
    "categories": List.generate(categories.length, (index) => true),
    "discrimination": [true, true, true, true, true],
    "difficulty": [true, true, true, true, true]
  };
  final categoryNames = List.generate(
    categories.length,
    (index) => categories[index].name,
  );
  return MixQuestionSearchFilterNotifier(
    initialFilters: initialFilters,
    categoryNames: categoryNames,
  );
});
