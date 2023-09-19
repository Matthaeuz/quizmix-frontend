import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/providers/categories/category_provider.dart';

class QuestionSearchFilterNotifier extends StateNotifier<Map<String, dynamic>> {
  Map<String, dynamic> initialFilters;
  List<String> categoryNames;

  QuestionSearchFilterNotifier({
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

final questionSearchFilterProvider =
    StateNotifierProvider<QuestionSearchFilterNotifier, Map<String, dynamic>>(
        (ref) {
  final categories = ref.watch(categoryProvider.notifier);
  
  final initialFilters = {
    "text": "",
    "categories": List.generate(categories.categoryLength, (index) => true),
    "discrimination": [true, true, true, true, true],
    "difficulty": [true, true, true, true, true]
  };
  final categoryNames = List.generate(
    categories.categoryLength,
    (index) => categories.categoryIndex(index)!.name,
  );
  return QuestionSearchFilterNotifier(
    initialFilters: initialFilters,
    categoryNames: categoryNames,
  );
});
