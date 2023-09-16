import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/quizzes/reviewer_quizzes_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewer/quizzes_list_screen.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_dashboard/add_card.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_dashboard/quiz_detail_card.dart';

class MyQuizzesList extends ConsumerWidget {
  const MyQuizzesList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizzes = ref.watch(reviewerQuizzesProvider);
    // final ScrollController controller = ScrollController();

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
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => QuizzesListScreen()));
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        quizzes.when(
          data: (quizzesData) => SizedBox(
            height: 200,
            child: ScrollConfiguration(
              behavior:
                  MyCustomScrollBehavior(), // Apply custom scroll behavior
              child: ListView.separated(
                physics:
                    const ClampingScrollPhysics(), // Disable vertical scrolling
                scrollDirection: Axis.horizontal,
                itemCount: quizzesData.length + 1,
                separatorBuilder: (context, index) => const SizedBox(width: 25),
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return const AddCard();
                  } else {
                    final quiz = quizzesData[index - 1];
                    return QuizDetailCard(quiz: quiz);
                  }
                },
              ),
            ),
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => SizedBox(
            height: 200,
            child: Row(
              children: [
                const AddCard(),
                Text('Error: $error'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        // etc.
      };
}
