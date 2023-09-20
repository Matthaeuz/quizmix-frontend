import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/platform_to_multipart_file.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/providers/api/base_url_provider.dart';
import 'package:quizmix_frontend/state/providers/api/dio_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/mix_questions/current_viewed_mix_question_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/available_quiz_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_quiz_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_viewed_quiz_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/quiz_question_search_filter_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/reviewee_quizzes_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/reviewer_quizzes_provider.dart';

Future<Quiz> updateQuiz(
  Quiz quiz,
  PlatformFile? imageFile,
  bool isFirstImageRemoved,
  WidgetRef ref,
) async {
  final dio = ref.watch(dioProvider);
  final baseUrl = ref.read(baseUrlProvider);
  final token = ref.watch(authTokenProvider).accessToken;

  dio.options.headers["Authorization"] = token;

  var quizData = quiz.toJson();

  dynamic dataToSend = quizData;
  final questionIdList = quiz.questions.map((question) => question.id).toList();

  if (imageFile != null) {
    // if new image
    final image = convertToMultipartFile(imageFile);
    final formData = FormData.fromMap({
      ...quizData,
      "made_by": quiz.madeBy.id,
      "image": image,
      "questions": questionIdList,
    });
    dataToSend = formData;
  } else if (isFirstImageRemoved == false) {
    // if same image
    quizData.remove('image');
    final formData = FormData.fromMap({
      ...quizData,
      "made_by": quiz.madeBy.id,
      "questions": questionIdList,
    });
    dataToSend = formData;
  } else {
    // if image is removed
    final formData = FormData.fromMap({
      ...quizData,
      "made_by": quiz.madeBy.id,
      "questions": questionIdList,
      "image": null,
    });
    dataToSend = formData;
  }

  try {
    var response = await dio.put(
      "$baseUrl/quizzes/${quiz.id}/",
      data: dataToSend,
    );

    if (response.statusCode == 200) {
      // If successful, convert the response body into a quiz
      Quiz updatedQuiz = Quiz.fromJson(response.data);

      // Update the provider
      ref.read(revieweeQuizzesProvider.notifier).fetchQuizzes();
      ref.read(reviewerQuizzesProvider.notifier).fetchQuizzes();
      ref.read(currentQuizViewedProvider.notifier).updateCurrentQuiz(updatedQuiz);
      ref.read(availableQuizQuestionsProvider.notifier).fetchQuestions();
      ref.read(currentQuizQuestionsProvider.notifier).fetchQuestions();
      ref.read(quizQuestionSearchFilterProvider.notifier).initializeFilters();
      ref
          .read(currentViewedMixQuestionProvider.notifier)
          .updateCurrentViewedQuestion(
              {"qnum": 0, "question": Question.base()});

      return updatedQuiz;
    } else {
      throw Exception('Failed to update the quiz');
    }
  } on DioException catch (_) {
    rethrow;
  }
}
