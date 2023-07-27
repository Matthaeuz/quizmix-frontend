import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/models/reviewees/reviewee.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';

//Refactor later!
final unassignedRevieweesProvider = FutureProvider.autoDispose<List<Reviewee>>((ref) async {
  final client = ref.watch(restClientProvider);
  final token = ref.watch(authTokenProvider);

  return await client.getUnassignedReviewees(token.accessToken);
});