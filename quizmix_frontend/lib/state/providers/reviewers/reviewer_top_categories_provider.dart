import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/categories/category.dart';
import 'package:quizmix_frontend/state/models/category_scores/category_score.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/categories/category_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';

class ReviewerTopCategoriesNotifier
    extends StateNotifier<AsyncValue<List<CategoryScore>>> {
  final RestClient client;
  final String accessToken;
  final int reviewerId;
  final List<Category> categories;

  ReviewerTopCategoriesNotifier({
    required this.client,
    required this.accessToken,
    required this.categories,
    required this.reviewerId,
  }) : super(const AsyncValue.loading()) {
    fetchReviewerTopCategories();
  }

  Future<void> fetchReviewerTopCategories() async {
    try {
      final categoryScoresObj = await client.getCategoryScores(accessToken);
      final validReviewees =
          await client.getReviewerReviewees(accessToken, reviewerId.toString());

      // Extract user IDs from validReviewees
      final Set<int> validUserIds =
          validReviewees.map((user) => user.user.id).toSet();

      // A map to accumulate category scores for valid categories
      final Map<String, double> categoryScoresMap = {};

      for (var categoryScoreObj in categoryScoresObj) {
        final categoryScoresStr = categoryScoreObj.value;
        final categoryScoresList = categoryScoresStr
            .split(',')
            .map((String str) => double.parse(str))
            .toList();

        if (validUserIds.contains(categoryScoreObj.user.id)) {
          for (var i = 0; i < categoryScoresList.length; i++) {
            final categoryName = categories[i].name;
            final currentScore = categoryScoresList[i];

            // Accumulate scores for each valid category
            categoryScoresMap.update(
              categoryName,
              (value) => value + currentScore,
              ifAbsent: () => currentScore,
            );
          }
        }
      }

      // Convert the map to a list of CategoryScore objects
      final reviewerTopCategories = categoryScoresMap.entries.map((entry) {
        return CategoryScore(category: entry.key, score: entry.value);
      }).toList();

      // Sort the categories by score in descending order
      reviewerTopCategories.sort((a, b) => b.score.compareTo(a.score));

      state = AsyncValue.data(reviewerTopCategories);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final reviewerTopCategoriesProvider = StateNotifierProvider<
    ReviewerTopCategoriesNotifier, AsyncValue<List<CategoryScore>>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final categories = ref.watch(categoryProvider.notifier);
  final reviewerId = ref.watch(userProvider).id;

  return ReviewerTopCategoriesNotifier(
      client: client,
      accessToken: token.accessToken,
      categories: categories.categories(),
      reviewerId: reviewerId);
});
