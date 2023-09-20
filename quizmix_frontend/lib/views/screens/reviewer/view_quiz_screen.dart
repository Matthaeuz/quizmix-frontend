import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/datetime_convert.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/quiz_questions/current_viewed_quiz_question_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_viewed_quiz_provider.dart';
// import 'package:quizmix_frontend/views/screens/reviewee/create_edit_mix_screen.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_view_quiz/view_quiz_question_container.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';
import 'package:quizmix_frontend/views/widgets/view_question_item.dart';

class ViewQuizScreen extends ConsumerStatefulWidget {
  const ViewQuizScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ViewQuizScreen> createState() => _ViewQuizScreenState();
}

class _ViewQuizScreenState extends ConsumerState<ViewQuizScreen> {
  @override
  Widget build(BuildContext context) {
    final currentQuiz = ref.watch(currentQuizViewedProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: screenWidth > 920 ? 1 : 3,
            child: Column(
              children: [
                Expanded(
                  flex: screenHeight > 360 ? 0 : 1,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed: () {
                                  ref
                                      .read(currentViewedQuizQuestionProvider
                                          .notifier)
                                      .updateCurrentViewedQuestion({
                                    "qnum": 0,
                                    "question": Question.base()
                                  });
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.centerLeft,
                                  foregroundColor: AppColors.mainColor,
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.arrow_back,
                                      size: 16.0,
                                      color: AppColors.mainColor,
                                    ),
                                    Text('Back to Home'),
                                  ],
                                ),
                              ),
                              Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  color: AppColors.fourthColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: currentQuiz.image != null
                                    ? Image(
                                        image: NetworkImage(currentQuiz.image!),
                                        fit: BoxFit.cover,
                                      )
                                    : Center(
                                        child: Text(
                                          currentQuiz.title[0],
                                          style: const TextStyle(
                                            color: AppColors.black,
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 24),
                                Text(
                                  currentQuiz.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${currentQuiz.numQuestions} ${currentQuiz.numQuestions > 1 ? "questions" : "question"}, ${currentQuiz.numCategories} ${currentQuiz.numCategories > 1 ? "categories" : "category"}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Created on: ${dateTimeToWordDate(currentQuiz.createdOn)}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                SolidButton(
                                  text: "Edit Quiz",
                                  icon: const Icon(Icons.edit),
                                  elevation: 8.0,
                                  onPressed: () {
                                    // ref
                                    //     .read(currentQuizViewedProvider.notifier)
                                    //     .updateCurrentQuiz(currentQuiz);
                                    // ref
                                    //     .read(availableMixQuestionsProvider
                                    //         .notifier)
                                    //     .fetchQuestions();
                                    // ref
                                    //     .read(currentMixQuestionsProvider
                                    //         .notifier)
                                    //     .fetchQuestions();
                                    // ref
                                    //     .read(mixQuestionSearchFilterProvider
                                    //         .notifier)
                                    //     .initializeFilters();
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         const CreateEditMixScreen(),
                                    //   ),
                                    // );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const ViewQuizQuestionContainer(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.mainColor,
              child: currentQuiz.questions.isNotEmpty
                  ? ListView.builder(
                      itemCount: currentQuiz.questions.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: index == 0 ? 24 : 0,
                              bottom: index == currentQuiz.questions.length - 1
                                  ? 24
                                  : 0,
                            ),
                            child: ViewQuestionItem(
                              questionNum: index + 1,
                              questionDetails: currentQuiz.questions[index],
                              condition: screenWidth > 920,
                              onClick: () {
                                ref
                                    .read(currentViewedQuizQuestionProvider
                                        .notifier)
                                    .updateCurrentViewedQuestion({
                                  "qnum": index + 1,
                                  "question": currentQuiz.questions[index]
                                });
                              },
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: EmptyDataPlaceholder(
                            message: "There are no questions in your Quiz",
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
