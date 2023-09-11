import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/categories/category.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';

class CategoryNotifier extends StateNotifier<List<Category>> {
  final RestClient client;
  final String accessToken;

  CategoryNotifier({
    required this.client,
    required this.accessToken,
  }) : super([]);

  void setCategories(List<Category> categories) {
    state = categories;
  }
}

final categoryProvider =
    StateNotifierProvider<CategoryNotifier, List<Category>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  return CategoryNotifier(client: client, accessToken: token.accessToken);
});
