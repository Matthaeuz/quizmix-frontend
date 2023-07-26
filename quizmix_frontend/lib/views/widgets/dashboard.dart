import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/screens/reviewer/dashboard_screen.dart';
import 'package:quizmix_frontend/views/screens/reviewer/view_question_bank_screen.dart';
import 'package:quizmix_frontend/views/screens/reviewer/reviewees_list_screen.dart';
import 'package:quizmix_frontend/views/screens/reviewer/view_profile_screen.dart';
import 'package:quizmix_frontend/views/widgets/profile_area.dart';

class DashboardWidget extends StatelessWidget {
  final String selectedOption;

  const DashboardWidget({Key? key, required this.selectedOption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  color: selectedOption == 'Dashboard'
                      ? AppColors.mainColor
                      : null,
                  child: ListTile(
                    leading: Icon(
                      Icons.dashboard,
                      color:
                          selectedOption == 'Dashboard' ? Colors.white : null,
                    ),
                    title: Text(
                      'Dashboard',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:
                            selectedOption == 'Dashboard' ? Colors.white : null,
                      ),
                    ),
                    onTap: () {
                      if (selectedOption != 'Dashboard') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DashboardScreen(),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  color: selectedOption == 'Reviewees'
                      ? AppColors.mainColor
                      : null,
                  child: ListTile(
                    leading: Icon(
                      Icons.person,
                      color:
                          selectedOption == 'Reviewees' ? Colors.white : null,
                    ),
                    title: Text(
                      'Reviewees',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:
                            selectedOption == 'Reviewees' ? Colors.white : null,
                      ),
                    ),
                    onTap: () {
                      if (selectedOption != 'Reviewees') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RevieweesListScreen(),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  color: selectedOption == 'Quizzes'
                      ? AppColors.mainColor
                      : null,
                  child: ListTile(
                    leading: Icon(
                      Icons.quiz,
                      color: selectedOption == 'Quizzes' ? Colors.white : null,
                    ),
                    title: Text(
                      'Quizzes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color:
                            selectedOption == 'Quizzes' ? Colors.white : null,
                      ),
                    ),
                    onTap: () {
                      if (selectedOption != 'Quizzes') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ViewProfileScreen(),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ViewQuestionBankScreen(),
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
