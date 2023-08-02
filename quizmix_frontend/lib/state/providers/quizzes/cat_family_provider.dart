import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/quizzes/cat_pool_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/cat_question_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/cat_specs_provider.dart';

final catFamilyProvider = ProviderFamily<Question?, int>((ref, questionNum) {
  ref.watch(catSpecsProvider).when(
        data: (data) {
          return data;
        },
        error: (err, st) {},
        loading: () {},
      );
  ref.watch(catPoolProvider);
  final currentQuestion = ref.watch(catQuestionProvider).when(
        data: (data) {
          return data;
        },
        error: (err, st) {},
        loading: () {},
      );

  return currentQuestion;
});
