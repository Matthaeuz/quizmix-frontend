import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/rest_client.dart';
import 'package:quizmix_frontend/state/providers/api/dio_provider.dart';

final restClientProvider = Provider<RestClient>((ref) {
  final dio = ref.read(dioProvider);
  return RestClient(dio);
});