import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/platform_to_multipart_file.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/dio_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/questions/question_bank_provider.dart';

// Future<Question> updateQuestion(
//     Question question, PlatformFile? imageFile, WidgetRef ref) async {
//   final dio = ref.watch(dioProvider);
//   final token = ref.watch(authTokenProvider).accessToken;

//   dio.options.headers["Authorization"] = token;

//   var questionData = question.toJson();

//   dynamic dataToSend = questionData;

//   // If there's an image file to be updated, pass it through form data, else can use json map
//   if (imageFile != null) {
//     final image = convertToMultipartFile(imageFile);
//     final formData = FormData.fromMap({
//       ...questionData,
//       "image": image,
//     });
//     dataToSend = formData;
//   } else {
//     dataToSend.remove('image');
//   }

//   try {
//     var response = await dio.put(
//         "http://127.0.0.1:8000/questions/${question.id}/",
//         data: dataToSend);

//     if (response.statusCode == 200) {
//       // If successful, convert the response body into a question
//       Question updatedQuestion = Question.fromJson(response.data);

//       // Update the provider
//       ref
//           .read(currentEditedQuestionProvider.notifier)
//           .updateCurrentEditedQuestion(updatedQuestion);
//       ref.read(questionBankProvider.notifier).fetchQuestions();
//       ref
//           .read(categoryQuestionsProvider(question.category.id).notifier)
//           .fetchQuestionsByCategory();

//       return updatedQuestion;
//     } else {
//       throw Exception('Failed to update the question');
//     }
//   } on DioException catch (_) {
//     rethrow;
//   }
// }

Future<Question> updateQuestion(
  Question question,
  PlatformFile? imageFile,
  bool isFirstImageRemoved,
  WidgetRef ref,
) async {
  final dio = ref.watch(dioProvider);
  final token = ref.watch(authTokenProvider).accessToken;

  dio.options.headers["Authorization"] = token;

  var questionData = question.toJson();
  questionData["category"] = question.category.id;
  questionData["choiceA"] = question.choices[0];
  questionData["choiceB"] = question.choices[1];
  questionData["choiceC"] = question.choices[2];
  questionData["choiceD"] = question.choices[3];

  dynamic dataToSend = questionData;

  if (imageFile != null) {
    // if new image
    final image = convertToMultipartFile(imageFile);
    final formData = FormData.fromMap({
      ...questionData,
      "image": image,
    });
    dataToSend = formData;
  } else if (isFirstImageRemoved == false) {
    // if same image
    final formData = FormData.fromMap(questionData);
    dataToSend = formData;
  } else {
    // if image is removed
    final formData = FormData.fromMap({
      ...questionData,
      "image": "",
    });
    dataToSend = formData;
  }

  try {
    var response = await dio.post(
        "http://127.0.0.1:8000/questions/update_question/",
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
