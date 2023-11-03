import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/datetime_convert.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/current_quiz_list_attempts_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_questions/current_viewed_quiz_question_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/available_quiz_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_quiz_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_viewed_quiz_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/quiz_question_search_filter_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/reviewer_quizzes_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/process_state_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewer/edit_quiz_screen.dart';
import 'package:quizmix_frontend/views/screens/reviewer/view_quiz_statistics_screen.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/question_grid.dart';
import 'package:quizmix_frontend/views/widgets/responsive_solid_button.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_view_quiz/view_quiz_question_container.dart';
import 'package:quizmix_frontend/views/widgets/view_question_item.dart';

class ViewQuizScreen extends ConsumerStatefulWidget {
  const ViewQuizScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ViewQuizScreen> createState() => _ViewQuizScreenState();
}

class _ViewQuizScreenState extends ConsumerState<ViewQuizScreen> {
  @override
  Widget build(BuildContext context) {
    final client = ref.watch(restClientProvider);
    final token = ref.watch(authTokenProvider).accessToken;
    final processState = ref.watch(processStateProvider);
    final currentQuiz = ref.watch(currentQuizViewedProvider);
    final attempts =
        ref.watch(currentQuizListAttemptsProvider.notifier).quizAttempts();
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
                      padding: const EdgeInsets.fromLTRB(24, 24, 0, 24),
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
                                Padding(
                                  padding: const EdgeInsets.only(right: 24.0),
                                  child: Text(
                                    currentQuiz.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Padding(
                                  padding: const EdgeInsets.only(right: 24.0),
                                  child: Text(
                                    "${currentQuiz.numQuestions} ${currentQuiz.numQuestions > 1 ? "questions" : "question"}, ${currentQuiz.numCategories} ${currentQuiz.numCategories > 1 ? "categories" : "category"}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 24.0),
                                  child: Text(
                                    "Created on: ${dateTimeToWordDate(currentQuiz.createdOn)}",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    ResponsiveSolidButton(
                                      text: "View Statistics",
                                      condition: screenWidth > 1380,
                                      icon: const Icon(Icons.bar_chart_rounded),
                                      elevation: 8.0,
                                      isUnpressable:
                                          processState == ProcessState.done
                                              ? false
                                              : true,
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ViewQuizStatisticsScreen(
                                                    quiz: currentQuiz),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(width: screenWidth > 540 ? 16 : 4),
                                    ResponsiveSolidButton(
                                      text: "Edit Quiz",
                                      condition: screenWidth > 1380,
                                      icon: const Icon(Icons.edit),
                                      elevation: 8.0,
                                      isUnpressable: attempts.isNotEmpty
                                          ? true
                                          : processState == ProcessState.done
                                              ? false
                                              : true,
                                      onPressed: () {
                                        ref
                                            .read(currentQuizViewedProvider
                                                .notifier)
                                            .updateCurrentQuiz(currentQuiz);
                                        ref
                                            .read(availableQuizQuestionsProvider
                                                .notifier)
                                            .fetchQuestions();
                                        ref
                                            .read(currentQuizQuestionsProvider
                                                .notifier)
                                            .fetchQuestions();
                                        ref
                                            .read(
                                                quizQuestionSearchFilterProvider
                                                    .notifier)
                                            .initializeFilters();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const EditQuizScreen(),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(width: screenWidth > 540 ? 16 : 4),
                                    ResponsiveSolidButton(
                                      text: "Delete Quiz",
                                      condition: screenWidth > 1380,
                                      icon: const Icon(Icons.delete),
                                      backgroundColor: AppColors.red,
                                      isUnpressable:
                                          processState == ProcessState.done
                                              ? false
                                              : true,
                                      elevation: 8.0,
                                      onPressed: () async {
                                        ref
                                            .read(processStateProvider.notifier)
                                            .updateProcessState(
                                                ProcessState.loading);
                                        try {
                                          await client.deleteQuizById(
                                              token, currentQuiz.id);

                                          ref
                                              .read(reviewerQuizzesProvider
                                                  .notifier)
                                              .fetchQuizzes()
                                              .then(
                                            (value) {
                                              ref
                                                  .read(processStateProvider
                                                      .notifier)
                                                  .updateProcessState(
                                                      ProcessState.done);
                                              Navigator.pop(context);
                                            },
                                          );
                                        } catch (err) {
                                          ref
                                              .read(
                                                  processStateProvider.notifier)
                                              .updateProcessState(
                                                  ProcessState.done);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // const Placeholder(),
                // const SizedBox(height: 20,),
                QuestionGrid(onPressed: () {}),
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
