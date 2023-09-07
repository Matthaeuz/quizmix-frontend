import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/categories/category.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';

class CategoryNotifier extends StateNotifier<AsyncValue<List<Category>>> {
  final RestClient client;
  final String accessToken;

  CategoryNotifier({
    required this.client,
    required this.accessToken,
  }) : super(const AsyncValue.loading()) {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      var categories = await client.getCategories(accessToken);
      state = AsyncValue.data(categories);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, AsyncValue<List<Category>>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  return CategoryNotifier(client: client, accessToken: token.accessToken);
});
