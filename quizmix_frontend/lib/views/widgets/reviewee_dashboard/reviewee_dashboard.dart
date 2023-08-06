import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
// import 'package:quizmix_frontend/state/providers/questions/current_question_provider.dart';
// import 'package:quizmix_frontend/state/providers/questions/question_bank_provider.dart';
// import 'package:quizmix_frontend/state/providers/questions/question_search_filter_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewee/my_mixes_screen.dart';
import 'package:quizmix_frontend/views/screens/view_question_bank_screen.dart';
import 'package:quizmix_frontend/views/screens/reviewee/my_quizzes_screen.dart';
import 'package:quizmix_frontend/views/widgets/profile_area.dart';

class RevieweeDashboardWidget extends ConsumerWidget {
  final String selectedOption;

  const RevieweeDashboardWidget({Key? key, required this.selectedOption})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Profile Area
            const ProfileArea(),
            // Dashboard Options
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  color: selectedOption == 'My Quizzes'
                      ? AppColors.mainColor
                      : null,
                  child: ListTile(
                    leading: Icon(
                      Icons.assignment,
                      color:
                          selectedOption == 'My Quizzes' ? Colors.white : null,
                    ),
                    title: Text(
                      'My Quizzes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: selectedOption == 'My Quizzes'
                            ? Colors.white
                            : null,
                      ),
                    ),
                    onTap: () {
                      if (selectedOption != 'My Quizzes') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyQuizzesScreen(),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  color:
                      selectedOption == 'My Mixes' ? AppColors.mainColor : null,
                  child: ListTile(
                    leading: Icon(
                      Icons.shuffle,
                      color: selectedOption == 'My Mixes' ? Colors.white : null,
                    ),
                    title: Text(
                      'My Mixes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:
                            selectedOption == 'My Mixes' ? Colors.white : null,
                      ),
                    ),
                    onTap: () {
                      if (selectedOption != 'My Mixes') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyMixesScreen(),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  color: selectedOption == 'Question Bank'
                      ? AppColors.mainColor
                      : null,
                  child: ListTile(
                    leading: Icon(
                      Icons.question_answer,
                      color: selectedOption == 'Question Bank'
                          ? Colors.white
                          : null,
                    ),
                    title: Text(
                      'Question Bank',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: selectedOption == 'Question Bank'
                            ? Colors.white
                            : null,
                      ),
                    ),
                    onTap: () {
                      if (selectedOption != 'Question Bank') {
                        // reset question bank screen
                        // ref
                        //     .read(questionBankProvider.notifier)
                        //     .fetchQuestions();
                        // ref
                        //     .read(questionSearchFilterProvider.notifier)
                        //     .initializeFilters();
                        // ref
                        //     .read(currentQuestionProvider.notifier)
                        //     .updateCurrentQuestion(null);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ViewQuestionBankScreen(
                              viewer: "reviewee",
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
