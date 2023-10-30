import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:quizmix_frontend/state/models/jsonresponse/jsonresponse.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';

Future<String> sendCode(String email, WidgetRef ref) async {
  // Define rest client
  final client = ref.watch(restClientProvider);

  try {
    // send verification code after mapping email
    Map<String, dynamic> payload = {
      "email": email,
    };

    var result = await client.sendCode(payload);

    return result.message;

  } on DioException catch (_) {
    rethrow;
  }
}
