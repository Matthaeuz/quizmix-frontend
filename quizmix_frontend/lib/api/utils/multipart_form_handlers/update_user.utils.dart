import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/platform_to_multipart_file.dart';
import 'package:quizmix_frontend/state/models/users/user.dart';
import 'package:quizmix_frontend/state/providers/api/dio_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';

Future<User> updateUser(PlatformFile? imageFile, WidgetRef ref) async {
  final dio = ref.watch(dioProvider);
  final token = ref.watch(authTokenProvider).accessToken;
  final user = ref.watch(userProvider);

  dio.options.headers["Authorization"] = token;

  dynamic dataToSend;
  if (imageFile != null) {
    final image = convertToMultipartFile(imageFile);
    dataToSend = FormData.fromMap({"image": image});
  } else {
    dataToSend = {"image": null};
  }

  try {
    var response = await dio.patch("http://127.0.0.1:8000/users/${user.id}/",
        data: dataToSend);

    if (response.statusCode == 200) {
      // If successful, convert the response body into a user
      User updatedUser = User.fromJson(response.data);

      // Update the provider
      ref.read(userProvider.notifier).updateUser(updatedUser);

      return updatedUser;
    } else {
      throw Exception('Failed to update the user');
    }
  } on DioException catch (_) {
    rethrow;
  }
}
