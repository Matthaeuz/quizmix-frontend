import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/models/quiz_attempts/quiz_attempt.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/question_attempts/all_question_attempts_provider.dart';
import 'package:quizmix_frontend/state/providers/question_attempts/current_question_attempts_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/current_quiz_attempted_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/current_quiz_list_attempts_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_viewed_quiz_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/statistics_table_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/views/screens/quiz_attempt_screen.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_view_quiz_statistics/quiz_histogram.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_view_quiz_statistics/quiz_statistics_attempts_container.dart';

class SortingNotifier extends StateNotifier<bool> {
  SortingNotifier() : super(true);

  void toggleSorting() {
    state = !state;
  }
}

final sortingProvider = StateNotifierProvider<SortingNotifier, bool>((ref) {
  return SortingNotifier();
});

class ViewQuizStatisticsScreen extends ConsumerWidget {
  final Quiz quiz;

  const ViewQuizStatisticsScreen({super.key, required this.quiz});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(restClientProvider);
    final token = ref.watch(authTokenProvider).accessToken;
    final List<QuizAttempt> firstAttempts = [];
    final isAscending = ref.watch(sortingProvider);

    final currentQuiz = ref.watch(currentQuizViewedProvider);

    // Get the list of questions from the currentQuiz
    final List<Question> currentQuestions = currentQuiz.questions;

    // Extract the question names from the list of questions
    final List<String> questionNames =
        currentQuestions.map((question) => question.question).toList();

    // Get the list of attempts from the currentQuizListAttemptsProvider
    final AsyncValue<List<QuizAttempt>> attempts =
        ref.watch(currentQuizListAttemptsProvider);

    attempts.maybeWhen(
      data: (data) {
        final Set<String> uniqueNames = {};
        for (final attempt in data) {
          final studentName = attempt.attemptedBy.fullName;
          if (!uniqueNames.contains(studentName)) {
            uniqueNames.add(studentName);
            firstAttempts.add(attempt);
          }
        }
      },
      orElse: () {
        return const Center(child: CircularProgressIndicator());
      },
    );

    const questionsPerPage = 5;

    final currentPage = ref.watch(currentPageProvider);

    List<DataColumn> generateDataColumns(
        int currentPage, int questionsPerPage, int totalQuestions) {
      final List<DataColumn> columns = [
        const DataColumn(label: Text('Name')),
      ];
      final int startIndex = currentPage * questionsPerPage;
      final int endIndex = startIndex + questionsPerPage;
      for (int i = startIndex; i < endIndex && i < totalQuestions; i++) {
        columns.add(DataColumn(label: Text('Q${i + 1}')));
      }
      return columns;
    }

// Generate DataColumn widgets for the current page
    List<DataColumn> dataColumns = generateDataColumns(
        currentPage, questionsPerPage, questionNames.length);

    List<DataRow> generateDataRows(
      List<QuizAttempt> firstAttempts,
      int currentPage,
      int questionsPerPage,
      List<String> questionNames,
      BuildContext context,
      WidgetRef ref,
    ) {
      final int startIndex = currentPage * questionsPerPage;
      final int endIndex =
          min(startIndex + questionsPerPage, questionNames.length);

      final allQuestionAttempts = ref.watch(allQuestionAttemptsProvider);

      final List<DataRow> rows = firstAttempts.asMap().entries.map((entry) {
        final QuizAttempt attempt = entry.value;
        final List<DataCell> cells = [
          DataCell(
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const QuizAttemptScreen(),
                  ),
                );
              },
              child: Text(attempt.attemptedBy.fullName),
            ),
          ),
        ];

        for (int i = startIndex; i < endIndex; i++) {
          final int questionIndex = i;
          cells.add(
            DataCell(
              allQuestionAttempts.when(
                data: (questionAttempts) {
                  final isCorrect = 
                      questionAttempts[questionIndex].isCorrect;
                  return Text(
                    isCorrect ? 'Correct' : 'Wrong',
                    style: TextStyle(
                      color: isCorrect ? AppColors.green : AppColors.red,
                    ),
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (_, __) => const Text('-'),
              ),
            ),
          );
        }

        return DataRow(
          cells: cells,
          onSelectChanged: (_) {
            ref
                .read(modalStateProvider.notifier)
                .updateModalState(ModalState.preparingReview);

            ref
                .read(currentQuizAttemptedProvider.notifier)
                .updateCurrentQuizAttempted(attempt, currentPage + 1);

            client.getQuestionAttemptsByQuizAttempt(token, attempt.id).then(
                (value) {
              ref
                  .read(currentQuestionAttemptsProvider.notifier)
                  .updateCurrentQuestionAttempts(value);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const QuizAttemptScreen(),
                ),
              );
              ref
                  .read(modalStateProvider.notifier)
                  .updateModalState(ModalState.none);
            }, onError: (err) {
              ref
                  .read(modalStateProvider.notifier)
                  .updateModalState(ModalState.none);
            });
          },
        );
      }).toList();

      return rows;
    }

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      alignment: Alignment.centerLeft,
                      foregroundColor: AppColors.white,
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.arrow_back,
                          size: 16.0,
                          color: AppColors.white,
                        ),
                        Text("Back to Quiz"),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    "${quiz.title} - Quiz Statistics",
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                ),
                // Histogram
                QuizHistogram(attempts: AsyncValue.data(firstAttempts)),
                // Table
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Container(
                    width: 800,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (currentPage > 0) {
                                    ref
                                        .read(currentPageProvider.notifier)
                                        .decrement();
                                    final newPage = currentPage - 1;
                                    final newColumns = generateDataColumns(
                                        newPage,
                                        questionsPerPage,
                                        questionNames.length);
                                    final newRows = generateDataRows(
                                        firstAttempts,
                                        newPage,
                                        questionsPerPage,
                                        questionNames,
                                        context,
                                        ref);
                                    ref
                                        .read(dataRowsProvider.notifier)
                                        .updateDataRows(newRows);
                                    ref
                                        .read(dataColumnsProvider.notifier)
                                        .updateDataColumns(newColumns);
                                  }
                                },
                                child: const Text("< Previous"),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  final nextPage = currentPage + 1;
                                  if (nextPage * questionsPerPage <
                                      questionNames.length) {
                                    ref
                                        .read(currentPageProvider.notifier)
                                        .increment();
                                    var newRows = generateDataRows(
                                        firstAttempts,
                                        currentPage,
                                        questionsPerPage,
                                        questionNames,
                                        context,
                                        ref);
                                    ref
                                        .read(dataRowsProvider.notifier)
                                        .updateDataRows(newRows);
                                  }
                                },
                                child: const Text("Next >"),
                              ),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Consumer(
                            builder: (context, ref, child) {
                              var newRows = generateDataRows(
                                  firstAttempts,
                                  currentPage,
                                  questionsPerPage,
                                  questionNames,
                                  context,
                                  ref);

                              return DataTable(
                                showCheckboxColumn: false,
                                columns: dataColumns,
                                rows: newRows,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                  child: Container(
                    width: 800,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 8),
                              Expanded(
                                flex: 2,
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.arrow_upward,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          'Reviewee',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                flex: 2,
                                child: TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.arrow_upward,
                                        color: Colors.black,
                                      ),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          'Date',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    ref
                                        .read(sortingProvider.notifier)
                                        .toggleSorting();
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        isAscending
                                            ? Icons.arrow_upward
                                            : Icons.arrow_downward,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(width: 4),
                                      const Expanded(
                                        child: Text(
                                          'Score',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                            ],
                          ),
                          const SizedBox(height: 8),
                          attempts.when(
                            data: (data) {
                              if (firstAttempts.isEmpty) {
                                return const EmptyDataPlaceholder(
                                    message:
                                        "There are currently no attempts for this quiz.");
                              }

                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: firstAttempts.length,
                                itemBuilder: (context, index) {
                                  // Sort your data based on the current sorting order
                                  final sortedAttempts = isAscending
                                      ? firstAttempts
                                      : List.from(firstAttempts.reversed);

                                  final attempt = sortedAttempts[index];

                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: InkWell(
                                      onTap: () async {
                                        ref
                                            .read(modalStateProvider.notifier)
                                            .updateModalState(
                                                ModalState.preparingReview);

                                        ref
                                            .read(currentQuizAttemptedProvider
                                                .notifier)
                                            .updateCurrentQuizAttempted(
                                                attempt, index + 1);

                                        client
                                            .getQuestionAttemptsByQuizAttempt(
                                                token, attempt.id)
                                            .then((value) {
                                          ref
                                              .read(
                                                  currentQuestionAttemptsProvider
                                                      .notifier)
                                              .updateCurrentQuestionAttempts(
                                                  value);

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const QuizAttemptScreen(),
                                            ),
                                          );
                                          ref
                                              .read(modalStateProvider.notifier)
                                              .updateModalState(
                                                  ModalState.none);
                                        }, onError: (err) {
                                          ref
                                              .read(modalStateProvider.notifier)
                                              .updateModalState(
                                                  ModalState.none);
                                        });
                                      },
                                      child: QuizStatisticsAttemptsContainer(
                                        attempt: attempt,
                                        color: AppColors.iconColor,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            error: (error, stack) =>
                                Center(child: Text('Error: $error')),
                            loading: () => const CircularProgressIndicator(),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
