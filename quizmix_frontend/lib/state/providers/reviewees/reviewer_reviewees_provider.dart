import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/models/reviewees/reviewee.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';

final reviewerRevieweesProvider = FutureProvider.autoDispose<List<Reviewee>>((ref) async {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);
  final userId = ref.watch(userProvider).id;

  return await client.getReviewerReviewees(token.accessToken, userId);
});