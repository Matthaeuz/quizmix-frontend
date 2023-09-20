import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/categories/category.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';

class CategoryNotifier extends StateNotifier<AsyncValue<List<Category>>> {
  final RestClient client;
  final String accessToken;
  late List<Category> allCategories;
  late bool hasCategories;

  CategoryNotifier({
    required this.client,
    required this.accessToken,
  }) : super(const AsyncValue.loading()) {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      var categories = await client.getCategories(accessToken);
      if (categories.isNotEmpty) {
        hasCategories = true;
      } else {
        hasCategories = false;
      }
      categories.sort((a, b) => a.id.compareTo(b.id));
      allCategories = categories;
      state = AsyncValue.data(categories);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  void setCategories(List<Category> categories) {
    state = AsyncValue.data(categories);
  }

  // use this for when you need to get the list without the AsyncValue data type
  List<Category> categories() {
    return state.when(
        data: (categories) => categories,
        loading: () => [],
        error: (error, stackTrace) => []);
  }

  // use this to get length of list
  int get categoryLength {
    return state.when(
        data: (categories) => categories.length,
        loading: () => 0,
        error: (error, stackTrace) => 0);
  }

  // use this to get indexing
  Category? categoryIndex(int index) {
    return state.when(
        data: (categories) =>
            categories.length > index ? categories[index] : null,
        loading: () => null,
        error: (error, stackTrace) => null);
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, AsyncValue<List<Category>>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  return CategoryNotifier(client: client, accessToken: token.accessToken);
});
