import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/current_quiz_attempted_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_taken_quiz_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewee_details_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewee/answer_quiz_screen.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class MyQuizItem extends ConsumerWidget {
  final Quiz quiz;

  const MyQuizItem({super.key, required this.quiz});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final firstLetter = quiz.title[0];
    final revieweeId = ref.read(revieweeProvider).when(
          data: (data) => data.id,
          error: (err, st) {},
          loading: () {},
        );
    final client = ref.watch(restClientProvider);
    final token = ref.watch(authTokenProvider).accessToken;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5), // Add border radius of 5
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.fourthColor,
              borderRadius: BorderRadius.circular(5), // Add border radius of 5
            ),
            child: Center(
              child: Text(
                firstLetter,
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              quiz.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SolidButton(
            onPressed: () {
              // Handle Review Attempts button press
            },
            text: 'Review Attempts',
            width: 150,
          ),
          const SizedBox(width: 12),
          SolidButton(
            onPressed: () {
              Map<String, int> details = {
                "attempted_by": revieweeId!,
                "quiz": quiz.id,
              };

              client.createQuizAttempt(token, details).then((value) {
                ref
                    .read(currentTakenQuizProvider.notifier)
                    .updateCurrentQuiz(quiz);
                ref
                    .read(currentQuizAttemptedProvider.notifier)
                    .updateCurrentQuizAttempted(value);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AnswerQuizScreen()));
              });
            },
            text: 'Answer',
            width: 150,
          ),
        ],
      ),
    );
  }
}
