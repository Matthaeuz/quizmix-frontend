import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/ui/tab_state_provider.dart';
import 'package:quizmix_frontend/views/widgets/profile_area.dart';
import 'package:quizmix_frontend/views/widgets/sign_out_area.dart';
import 'package:quizmix_frontend/views/widgets/tab_item.dart';

class TabsWidget extends ConsumerWidget {
  const TabsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabState = ref.watch(tabStateProvider);
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      color: AppColors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileArea(),
            TabItem(
              onTap: () {
                if (tabState != TabState.revieweeQuizzes) {
                  ref
                      .read(tabStateProvider.notifier)
                      .updateTabState(TabState.revieweeQuizzes);
                }
              },
              text: "My Quizzes",
              icon: Icons.assignment,
              isSelected: tabState == TabState.revieweeQuizzes,
            ),
            TabItem(
              onTap: () {
                if (tabState != TabState.revieweeMixes) {
                  ref
                      .read(tabStateProvider.notifier)
                      .updateTabState(TabState.revieweeMixes);
                }
              },
              text: "My Mixes",
              icon: Icons.shuffle,
              isSelected: tabState == TabState.revieweeMixes,
            ),
            TabItem(
              onTap: () {
                if (tabState != TabState.revieweeQuestionBank) {
                  ref
                      .read(tabStateProvider.notifier)
                      .updateTabState(TabState.revieweeQuestionBank);
                }
              },
              text: "Question Bank",
              icon: Icons.question_answer,
              isSelected: tabState == TabState.revieweeQuestionBank,
            ),
            SizedBox(height: screenHeight >= 364 ? screenHeight - 364 : 0),
            const SignOutArea(),
          ],
        ),
      ),
    );
    // return Expanded(
    //   flex: 2,
    //   child: Container(
    //     color: Colors.white,
    //     child: Column(
    //       children: [
    //         // Profile Area
    //         const ProfileArea(),
    //         // Dashboard Options
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             const SizedBox(height: 20),
    //             Container(
    //               color: selectedOption == 'My Quizzes'
    //                   ? AppColors.mainColor
    //                   : null,
    //               child: ListTile(
    //                 leading: Icon(
    //                   Icons.assignment,
    //                   color:
    //                       selectedOption == 'My Quizzes' ? Colors.white : null,
    //                 ),
    //                 title: Text(
    //                   'My Quizzes',
    //                   style: TextStyle(
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.bold,
    //                     color: selectedOption == 'My Quizzes'
    //                         ? Colors.white
    //                         : null,
    //                   ),
    //                 ),
    //                 onTap: () {
    //                   if (selectedOption != 'My Quizzes') {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) => const MyQuizzesScreen(),
    //                       ),
    //                     );
    //                   }
    //                 },
    //               ),
    //             ),
    //             const SizedBox(height: 20),
    //             Container(
    //               color:
    //                   selectedOption == 'My Mixes' ? AppColors.mainColor : null,
    //               child: ListTile(
    //                 leading: Icon(
    //                   Icons.shuffle,
    //                   color: selectedOption == 'My Mixes' ? Colors.white : null,
    //                 ),
    //                 title: Text(
    //                   'My Mixes',
    //                   style: TextStyle(
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.bold,
    //                     color:
    //                         selectedOption == 'My Mixes' ? Colors.white : null,
    //                   ),
    //                 ),
    //                 onTap: () {
    //                   if (selectedOption != 'My Mixes') {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) => const MyMixesScreen(),
    //                       ),
    //                     );
    //                   }
    //                 },
    //               ),
    //             ),
    //             const SizedBox(height: 20),
    //             Container(
    //               color: selectedOption == 'Question Bank'
    //                   ? AppColors.mainColor
    //                   : null,
    //               child: ListTile(
    //                 leading: Icon(
    //                   Icons.question_answer,
    //                   color: selectedOption == 'Question Bank'
    //                       ? Colors.white
    //                       : null,
    //                 ),
    //                 title: Text(
    //                   'Question Bank',
    //                   style: TextStyle(
    //                     fontSize: 16,
    //                     fontWeight: FontWeight.bold,
    //                     color: selectedOption == 'Question Bank'
    //                         ? Colors.white
    //                         : null,
    //                   ),
    //                 ),
    //                 onTap: () {
    //                   if (selectedOption != 'Question Bank') {
    //                     // reset question bank screen
    //                     // ref
    //                     //     .read(questionBankProvider.notifier)
    //                     //     .fetchQuestions();
    //                     // ref
    //                     //     .read(questionSearchFilterProvider.notifier)
    //                     //     .initializeFilters();
    //                     // ref
    //                     //     .read(currentQuestionProvider.notifier)
    //                     //     .updateCurrentQuestion(null);
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) => const ViewQuestionBankScreen(
    //                           viewer: "reviewee",
    //                         ),
    //                       ),
    //                     );
    //                   }
    //                 },
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
