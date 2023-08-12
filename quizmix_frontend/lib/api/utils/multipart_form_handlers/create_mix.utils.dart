import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/platform_to_multipart_file.dart';
import 'package:quizmix_frontend/state/models/mixes/mix.dart';
import 'package:quizmix_frontend/state/providers/api/dio_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/reviewee_mixes_provider.dart';

Future<Mix> createMix(
  Map<String, dynamic> mixData,
  PlatformFile? imageFile,
  WidgetRef ref,
) async {
  final dio = ref.watch(dioProvider);
  final token = ref.watch(authTokenProvider).accessToken;

  dio.options.headers["Authorization"] = token;
  dynamic dataToSend = mixData;

  // If there's an image file to be updated, pass it through form data
  if (imageFile != null) {
    final image = convertToMultipartFile(imageFile);
    final formData = FormData.fromMap({
      ...mixData,
      "image": image,
    });
    dataToSend = formData;
  } else {
    final formData = FormData.fromMap(mixData);
    dataToSend = formData;
  }

  try {
    var response = await dio.post(
      "http://127.0.0.1:8000/mixes/create_mix/",
      data: dataToSend,
    );

    if (response.statusCode == 201) {
      // If successful, convert the response body into a mix
      Mix newMix = Mix.fromJson(response.data);

      // Update the provider
      ref.read(revieweeMixesProvider.notifier).fetchMixes();

      return newMix;
    } else {
      throw Exception('Failed to create the mix');
    }
  } on DioException catch (_) {
    rethrow;
  }
}
