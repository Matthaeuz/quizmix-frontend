import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/platform_to_multipart_file.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/dio_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';

import 'package:dio/dio.dart';

Future<void> createQuestionsFromPdf(PlatformFile aFile, PlatformFile qFile, WidgetRef ref) async {
  final dio = ref.watch(dioProvider);
  final token = ref.watch(authTokenProvider).accessToken;

  dio.options.headers["Authorization"] = token;

  var aMultipartFile = convertToMultipartFile(aFile);
  var qMultipartFile = convertToMultipartFile(qFile);

  var formData = FormData.fromMap({
    "a_file": aMultipartFile,
    "q_file": qMultipartFile,
  });

  try {
    await dio.post("http://127.0.0.1:8000/questions/create_questions_from_pdf/", data: formData);
  } on DioException catch (_) {
    rethrow;
  }
}