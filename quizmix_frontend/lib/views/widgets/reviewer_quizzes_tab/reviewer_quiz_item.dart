import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/datetime_convert.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/current_quiz_list_attempts_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_viewed_quiz_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/process_state_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewer/view_quiz_screen.dart';

class ReviewerQuizItem extends ConsumerWidget {
  final Quiz quiz;

  const ReviewerQuizItem({super.key, required this.quiz});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () async {
          ref
              .read(processStateProvider.notifier)
              .updateProcessState(ProcessState.loading);
          ref.read(currentQuizViewedProvider.notifier).updateCurrentQuiz(quiz);
          await ref
              .read(currentQuizListAttemptsProvider.notifier)
              .fetchCurrentQuizListAttempts()
              .then((value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ViewQuizScreen(),
              ),
            );
            ref
                .read(processStateProvider.notifier)
                .updateProcessState(ProcessState.done);
          });
        },
        child: Container(
          width: 352,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      color: AppColors.fourthColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: quiz.image != null
                          ? Image(
                              image: NetworkImage(quiz.image!),
                              fit: BoxFit.cover,
                            )
                          : Center(
                              child: Text(
                                quiz.title[0],
                                style: const TextStyle(
                                  color: AppColors.black,
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quiz.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${quiz.numQuestions} ${quiz.numQuestions > 1 ? "questions" : "question"}, ${quiz.numCategories} ${quiz.numCategories > 1 ? "categories" : "category"}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        "Created on: ${dateTimeToWordDate(quiz.createdOn)}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
