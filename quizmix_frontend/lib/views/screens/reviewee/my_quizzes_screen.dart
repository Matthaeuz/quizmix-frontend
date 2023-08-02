import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/providers/quizzes/reviewee_quizzes_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_dashboard/my_quiz_item.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_dashboard/reviewee_dashboard.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/widgets/search_input.dart';

class MyQuizzesScreen extends ConsumerStatefulWidget {
  const MyQuizzesScreen({Key? key}) : super(key: key);

  @override
  _MyQuizzesScreenState createState() => _MyQuizzesScreenState();
}

class _MyQuizzesScreenState extends ConsumerState<MyQuizzesScreen> {
  @override
  Widget build(BuildContext context) {
    final quizzes = ref.watch(revieweeQuizzesProvider);

    return Scaffold(
      body: Row(
        children: [
          // Left Side - Dashboard
          const RevieweeDashboardWidget(
            selectedOption: 'My Quizzes',
          ),
          // Right Side - List of Quizzes
          Expanded(
            flex: 8,
            child: Container(
              color: AppColors.fifthColor,
              padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search Input
                  SearchInput(
                    onChanged: (value) {
                      // Handle search input changes
                    },
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: Consumer(
                      builder: (context, watch, child) {
                        return quizzes.when(
                          data: (data) {
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final quiz = data[index];
                                return Column(
                                  children: [
                                    MyQuizItem(quiz: quiz),
                                    const SizedBox(height: 25),
                                  ],
                                );
                              },
                            );
                          },
                          loading: () => const Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                          error: (err, stack) => Text('Error: $err'),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
