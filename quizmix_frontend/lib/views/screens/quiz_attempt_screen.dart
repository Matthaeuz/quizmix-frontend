import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/datetime_convert.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/question_attempts/question_attempt.dart';
import 'package:quizmix_frontend/state/providers/question_attempts/current_question_attempts_provider.dart';
import 'package:quizmix_frontend/state/providers/question_attempts/currently_viewed_question_attempt_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/current_quiz_attempted_provider.dart';
import 'package:quizmix_frontend/views/widgets/view_question_attempt_container.dart';
import 'package:quizmix_frontend/views/widgets/view_question_item.dart';
import 'package:quizmix_frontend/views/widgets/view_question_item_dna.dart';

class QuizAttemptScreen extends ConsumerStatefulWidget {
  const QuizAttemptScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<QuizAttemptScreen> createState() => _QuizAttemptScreenState();
}

class _QuizAttemptScreenState extends ConsumerState<QuizAttemptScreen> {
  @override
  Widget build(BuildContext context) {
    final currentQuizAttempt = ref.watch(currentQuizAttemptedProvider);
    final currentQuestionAttempts = ref.watch(currentQuestionAttemptsProvider);
    final currentQuiz = currentQuizAttempt.quiz;
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
                                      .read(currentViewedQuestionAttemptProvider
                                          .notifier)
                                      .updateCurrentViewedQuestionAttempt({
                                    "qanum": 0,
                                    "questionAttempt": QuestionAttempt.base()
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
                                  currentQuizAttempt.attemptedBy.fullName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "${dateTimeToWordDate(currentQuizAttempt.createdOn)}, ${dateTimeToTime(currentQuizAttempt.timeStarted)}-${currentQuizAttempt.timeFinished != null ? dateTimeToTime(currentQuizAttempt.timeFinished!) : "N/A"}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "Attempt No. ${ref.read(currentQuizAttemptedProvider.notifier).attemptNum}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Score: ${currentQuizAttempt.attemptScore}/${currentQuiz.questions.length}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const ViewQuestionAttemptContainer(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.mainColor,
              child: ListView.builder(
                itemCount: currentQuiz.questions.length,
                itemBuilder: (context, index) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: index == 0 ? 24 : 0,
                        bottom:
                            index == currentQuiz.questions.length - 1 ? 24 : 0,
                      ),
                      child: index < currentQuestionAttempts.length
                          ? ViewQuestionItem(
                              questionNum: index + 1,
                              questionDetails:
                                  currentQuestionAttempts[index].question,
                              condition: screenWidth > 920,
                              color: currentQuestionAttempts[index].isCorrect
                                  ? AppColors.green
                                  : AppColors.red,
                              onClick: () {
                                ref
                                    .read(currentViewedQuestionAttemptProvider
                                        .notifier)
                                    .updateCurrentViewedQuestionAttempt({
                                  "qanum": index + 1,
                                  "questionAttempt":
                                      currentQuestionAttempts[index]
                                });
                              },
                            )
                          : ViewQuestionItemDNA(condition: screenWidth > 920),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
