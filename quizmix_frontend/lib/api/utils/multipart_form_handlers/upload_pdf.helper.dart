import 'package:dio/dio.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/platform_to_multipart_file.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/dio_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/questions/uploaded_questions_provider.dart';

/// Takes an aFile and a qFile and creates a list of 80 questions based on a PhilNITS PDF file.
Future<List<Question>> createQuestionsFromPdf(PlatformFile aFile, PlatformFile qFile, WidgetRef ref) async {
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
    var response = await dio.post("http://127.0.0.1:8000/questions/create_questions_from_pdf/", data: formData);

    if(response.statusCode == 201) {
      // If successful, convert the response body into a list of questions
      List<Question> questions = (response.data as List).map((i) => Question.fromJson(i)).toList();
      // Update the provider
      ref.read(uploadedQuestionsProvider.notifier).updateUploadedQuestions(questions);
      for (Question question in questions) {
        debugPrint('${question.image}');
      }
      return questions;
    } else {
      throw Exception('Failed to load questions');
    }
  } on DioException catch (_) {
    rethrow;
  }
}
