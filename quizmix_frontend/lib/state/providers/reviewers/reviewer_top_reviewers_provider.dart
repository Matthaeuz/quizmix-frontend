import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/categories/category.dart';
import 'package:quizmix_frontend/state/models/users/user.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/categories/category_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';

class RevieweeData {
  final User user;
  final double averageScore;

  RevieweeData({required this.user, required this.averageScore});
}

class ReviewerTopRevieweesNotifier
    extends StateNotifier<AsyncValue<List<RevieweeData>>> {
  final RestClient client;
  final String accessToken;
  final int reviewerId;
  final List<Category> categories;

  ReviewerTopRevieweesNotifier({
    required this.client,
    required this.accessToken,
    required this.categories,
    required this.reviewerId,
  }) : super(const AsyncValue.loading()) {
    fetchReviewerTopReviewees();
  }

  Future<void> fetchReviewerTopReviewees() async {
    try {
      final categoryScoresObj = await client.getCategoryScores(accessToken);
      final validReviewees =
          await client.getReviewerReviewees(accessToken, reviewerId.toString());

      // Map to store reviewee names and their scores
      final Map<String, List<double>> revieweeScoresMap = {};

      for (var categoryScoreObj in categoryScoresObj) {
        final userId = categoryScoreObj.user.id;
        final categoryScoresStr = categoryScoreObj.value;
        final categoryScoresList = categoryScoresStr
            .split(',')
            .map((String str) => double.parse(str))
            .toList();

        if (validReviewees.any((reviewee) => reviewee.user.id == userId)) {
          final userName = validReviewees
              .firstWhere((reviewee) => reviewee.user.id == userId)
              .user
              .fullName; // Use fullName from User model

          revieweeScoresMap.putIfAbsent(userName, () => []);

          for (var i = 0; i < categoryScoresList.length; i++) {
            final currentScore = categoryScoresList[i];

            // Accumulate scores for each valid reviewee
            revieweeScoresMap[userName]!.add(currentScore);
          }
        }
      }

      // Calculate average score for each reviewee
      final List<RevieweeData> reviewerTopReviewees = revieweeScoresMap.entries.map((entry) {
        final userName = entry.key;
        final scores = entry.value;

        final user = validReviewees.firstWhere((reviewee) => reviewee.user.fullName == userName).user;

        final averageScore = scores.isNotEmpty ? scores.reduce((a, b) => a + b) / scores.length : 0.0;

        return RevieweeData(user: user, averageScore: averageScore);
      }).toList();

      // Sort the reviewees by average score in descending order
      reviewerTopReviewees.sort((a, b) => b.averageScore.compareTo(a.averageScore));

      state = AsyncValue.data(reviewerTopReviewees);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final reviewerTopRevieweesProvider = StateNotifierProvider<
    ReviewerTopRevieweesNotifier, AsyncValue<List<RevieweeData>>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final categories = ref.watch(categoryProvider.notifier);
  final reviewerId = ref.watch(userProvider).id;

  return ReviewerTopRevieweesNotifier(
      client: client,
      accessToken: token.accessToken,
      categories: categories.categories(),
      reviewerId: reviewerId);
});
