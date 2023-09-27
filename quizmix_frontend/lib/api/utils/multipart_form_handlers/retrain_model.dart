import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/platform_to_multipart_file.dart';
import 'package:quizmix_frontend/state/providers/api/base_url_provider.dart';
import 'package:quizmix_frontend/state/providers/api/dio_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/categories/category_provider.dart';
import 'package:quizmix_frontend/state/providers/questions/question_bank_provider.dart';

Future<void> retrainModel(PlatformFile dataset, WidgetRef ref) async {
  final baseUrl = ref.read(baseUrlProvider);
  
  final dio = ref.watch(dioProvider);
  final token = ref.watch(authTokenProvider).accessToken;

  dio.options.headers["Authorization"] = token;
  
  // convert dataset to multipart; backend confirms valid file type, accepts .csv and .xslx
  var multipartDataset = convertToMultipartFile(dataset);

  var formData = FormData.fromMap({
    "dataset": multipartDataset,
  });

  try {
    var response = await dio.post("$baseUrl/train/", data: formData);

    if(response.statusCode == 200) {
      // if successful, refresh all providers that make use of categories and questions
      ref.read(categoryProvider.notifier).fetchCategories();
      ref.read(questionBankProvider.notifier).fetchQuestions();
    } else {
      throw Exception('Something wrong happened during retraining.');
    }
  } on DioException catch (_) {
    rethrow;
  }
}