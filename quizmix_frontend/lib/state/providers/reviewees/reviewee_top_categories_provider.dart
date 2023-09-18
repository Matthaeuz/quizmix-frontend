import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/categories/category.dart';
import 'package:quizmix_frontend/state/models/category_scores/category_score.dart';
import 'package:quizmix_frontend/state/models/quiz_attempts/quiz_attempt.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/categories/category_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/current_quiz_attempted_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/current_viewed_reviewee_provider.dart';

class RevieweeTopCategoriesNotifier
    extends StateNotifier<AsyncValue<List<CategoryScore>>> {
  final RestClient client;
  final String accessToken;
  final int revieweeId;
  final List<Category> categories;
  final QuizAttempt listener;

  RevieweeTopCategoriesNotifier({
    required this.client,
    required this.accessToken,
    required this.revieweeId,
    required this.categories,
    required this.listener,
  }) : super(const AsyncValue.loading()) {
    fetchRevieweeTopCategories();
  }

  Future<void> fetchRevieweeTopCategories() async {
    try {
      final categoryScoresObj =
          await client.getRevieweeCategoryScores(accessToken, revieweeId);
      final categoryScoresStr = categoryScoresObj[0].value;
      final categoryScoresList = categoryScoresStr
          .split(',')
          .map((String str) => double.parse(str))
          .toList();

      List<CategoryScore> revieweeTopCategories = [];
      for (var i = 0; i < categoryScoresList.length; i++) {
        final newCategoryScore = CategoryScore(
          category: categories[i].name,
          score: categoryScoresList[i],
        );
        final insertIndex = revieweeTopCategories.indexWhere(
            (categoryScore) => categoryScore.score <= newCategoryScore.score);
        revieweeTopCategories.isEmpty || insertIndex == -1
            ? revieweeTopCategories.add(newCategoryScore)
            : revieweeTopCategories.insert(insertIndex, newCategoryScore);
      }
      state = AsyncValue.data(revieweeTopCategories);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final revieweeTopCategoriesProvider = StateNotifierProvider<
    RevieweeTopCategoriesNotifier, AsyncValue<List<CategoryScore>>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final reviewee = ref.watch(currentViewedRevieweeProvider);
  final categories = ref.watch(categoryProvider);
  final listener = ref.watch(currentQuizAttemptedProvider);

  return RevieweeTopCategoriesNotifier(
    client: client,
    accessToken: token.accessToken,
    revieweeId: reviewee.id,
    categories: categories,
    listener: listener,
  );
});
