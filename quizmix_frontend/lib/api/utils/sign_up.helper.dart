import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/users/signup_details.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';

Future<void> signUp(SignUpDetails details, WidgetRef ref) async {
  final client = ref.watch(restClientProvider);

  try {
    await client.signUp(details);
  } on DioException catch (_) {
    rethrow;
  }
}
