import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/platform_to_multipart_file.dart';
import 'package:quizmix_frontend/state/models/mixes/mix.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/dio_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/mix_questions/current_viewed_mix_question_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/available_mix_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/mix_question_search_filter_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/reviewee_mixes_provider.dart';

Future<Mix> updateMix(
  Mix mix,
  PlatformFile? imageFile,
  bool isFirstImageRemoved,
  WidgetRef ref,
) async {
  final dio = ref.watch(dioProvider);
  final token = ref.watch(authTokenProvider).accessToken;

  dio.options.headers["Authorization"] = token;

  var mixData = mix.toJson();

  dynamic dataToSend = mixData;
  final questionIdList = mix.questions.map((question) => question.id).toList();

  if (imageFile != null) {
    // if new image
    final image = convertToMultipartFile(imageFile);
    final formData = FormData.fromMap({
      ...mixData,
      "made_by": mix.madeBy.id,
      "image": image,
      "questions": questionIdList,
    });
    dataToSend = formData;
  } else if (isFirstImageRemoved == false) {
    // if same image
    mixData.remove('image');
    final formData = FormData.fromMap({
      ...mixData,
      "made_by": mix.madeBy.id,
      "questions": questionIdList,
    });
    dataToSend = formData;
  } else {
    // if image is removed
    final formData = FormData.fromMap({
      ...mixData,
      "made_by": mix.madeBy.id,
      "questions": questionIdList,
      "image": null,
    });
    dataToSend = formData;
  }

  // If there's an image file to be updated, pass it through form data, else can use json map
  // if (imageFile != null) {
  //   final image = convertToMultipartFile(imageFile);
  //   final formData = FormData.fromMap({
  //     ...mixData,
  //     "made_by": mix.madeBy.id,
  //     "image": image,
  //     "questions": questionIdList,
  //   });
  //   dataToSend = formData;
  // } else {
  //   mixData.remove('image');
  //   final formData = FormData.fromMap({
  //     ...mixData,
  //     "made_by": mix.madeBy.id,
  //     "questions": questionIdList,
  //   });
  //   dataToSend = formData;
  // }
  // print('${dataToSend.fields}');

  try {
    var response = await dio.put(
      "http://127.0.0.1:8000/mixes/${mix.id}/",
      data: dataToSend,
    );

    if (response.statusCode == 200) {
      // If successful, convert the response body into a mix
      Mix updatedMix = Mix.fromJson(response.data);

      // Update the provider
      ref.read(revieweeMixesProvider.notifier).fetchMixes();
      ref.read(currentMixProvider.notifier).updateCurrentMix(updatedMix);
      ref.read(availableMixQuestionsProvider.notifier).fetchQuestions();
      ref.read(currentMixQuestionsProvider.notifier).fetchQuestions();
      ref.read(mixQuestionSearchFilterProvider.notifier).initializeFilters();
      ref
          .read(currentViewedMixQuestionProvider.notifier)
          .updateCurrentViewedQuestion(
              {"qnum": 0, "question": Question.base()});

      return updatedMix;
    } else {
      throw Exception('Failed to update the mix');
    }
  } on DioException catch (_) {
    rethrow;
  }
}
