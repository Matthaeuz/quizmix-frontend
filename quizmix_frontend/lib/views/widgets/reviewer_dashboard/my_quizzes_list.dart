import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/quizzes/reviewer_quizzes_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_dashboard/add_card.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_dashboard/quiz_detail_card.dart';

class MyQuizzesList extends ConsumerWidget {
  const MyQuizzesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzes = ref.watch(reviewerQuizzesProvider);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "My Quizzes",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.mainColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Handle View All onPress
              },
              child: const Text(
                'View All',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        quizzes.when(
          data: (quizzesData) => SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: quizzesData.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const AddCard();
                } else {
                  final quiz = quizzesData[index - 1];
                  return QuizDetailCard(title: quiz.title, image: quiz.image);
                }
              },
            ),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => Text('Error: $error'),
        ),
      ],
    );
  }
}
