import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/models/auth/auth_details.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewee_details_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewers/reviewer_details_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';

/// Used to sign in. Provide [AuthDetails] with a valid email and password.
Future<void> signIn(AuthDetails details, WidgetRef ref) async {
  // Define rest client
  final client = ref.watch(restClientProvider); 

  try {
    // Get a token if user credentials are valid and save it
    final token = await client.signIn(details);
    ref.read(authTokenProvider.notifier).updateToken(token);

    // Get user details and save to provider
    final user = await client.getUserByEmail(token.accessToken, details.email);
    final userType = user[0].userType;

    ref.read(userProvider.notifier).updateUser(user[0]);

    // Check user type and save details appropriately
    if (userType == 'reviewee') {
      final reviewee = await client.getRevieweeByUserId(token.accessToken, user[0].id);
      ref.read(revieweeProvider.notifier).updateReviewee(reviewee[0]);
    } else {
      final reviewer = await client.getReviewerByUserId(token.accessToken, user[0].id);
      ref.read(reviewerProvider.notifier).updateReviewee(reviewer[0]);
    }
  } on DioException catch (_) {
    rethrow;
  }
}