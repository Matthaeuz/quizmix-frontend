import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/models/quiz_attempts/quiz_attempt.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';

class FirstQuizAttemptNotifier
    extends StateNotifier<AsyncValue<List<QuizAttempt>>> {
  final RestClient client;
  final String accessToken;
  final int reviewerId;

  FirstQuizAttemptNotifier({
    required this.client,
    required this.accessToken,
    required this.reviewerId,
  }) : super(const AsyncValue.loading()) {
    fetchFirstQuizAttempts();
  }

  Future<void> fetchFirstQuizAttempts() async {
    try {
      var firstQuizAttempts =
          await client.getFirstAttemptsOfQuizzes(accessToken);
      final validReviewees =
          await client.getReviewerReviewees(accessToken, reviewerId.toString());

      // Filter the firstQuizAttempts to only include attempts by valid reviewees
      firstQuizAttempts = firstQuizAttempts.where((attempt) {
        return validReviewees
            .any((reviewee) => reviewee.user.id == attempt.attemptedBy.id);
      }).toList();

       // Sort firstQuizAttempts by created_on in descending order
      firstQuizAttempts.sort((a, b) => a.createdOn.compareTo(b.createdOn));

      state = AsyncValue.data(firstQuizAttempts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final firstQuizAttemptProvider = StateNotifierProvider<FirstQuizAttemptNotifier,
    AsyncValue<List<QuizAttempt>>>((ref) {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final reviewerId = ref.watch(userProvider).id;

  return FirstQuizAttemptNotifier(
      client: client, accessToken: token.accessToken, reviewerId: reviewerId);
});
