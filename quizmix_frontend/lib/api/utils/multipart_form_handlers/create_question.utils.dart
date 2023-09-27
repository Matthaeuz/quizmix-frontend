import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/platform_to_multipart_file.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/dio_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/questions/question_bank_provider.dart';

Future<Question> createQuestion(Map<String, dynamic> questionData,
    PlatformFile? imageFile, WidgetRef ref) async {
  final dio = ref.watch(dioProvider);
  final token = ref.watch(authTokenProvider).accessToken;

  dio.options.headers["Authorization"] = token;

  dynamic dataToSend = questionData;

  // If there's an image file to be updated, pass it through form data, else can use json map
  if (imageFile != null) {
    final image = convertToMultipartFile(imageFile);
    final formData = FormData.fromMap({
      ...questionData,
      "image": image,
    });
    dataToSend = formData;
  } else {
    final formData = FormData.fromMap(questionData);
    dataToSend = formData;
  }

  try {
    var response = await dio.post(
        "http://127.0.0.1:8000/questions/create_question/",
        data: dataToSend);

    if (response.statusCode == 201) {
      // If successful, convert the response body into a question
      Question updatedQuestion = Question.fromJson(response.data);

      // Update the provider
      ref.read(questionBankProvider.notifier).fetchQuestions();

      return updatedQuestion;
    } else {
      throw Exception('Failed to create the question');
    }
  } on DioException catch (_) {
    rethrow;
  }
}
