import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/api/base_url_provider.dart';
import 'package:quizmix_frontend/state/providers/question_attempts/currently_viewed_question_attempt_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/quiz_attempt_questions_responses_provider.dart';
import 'package:quizmix_frontend/views/widgets/correctness_icon.dart';

class ViewQuestionAttemptContainer extends ConsumerWidget {
  const ViewQuestionAttemptContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final choiceLetters = ['A.', 'B.', 'C.', 'D.'];
    final baseUrl = ref.watch(baseUrlProvider);
    final questionDetails = ref.watch(currentViewedQuestionAttemptProvider);
    final attemptDetails = ref.watch(quizAttemptQuestionsResponsesProvider);
    final questionNum = questionDetails["qnum"];
    final question = questionDetails["question"];
    final response = attemptDetails.when(
      data: (data) {
        final questionInd = questionNum > 0 ? questionNum - 1 : 0;
        return data.responses[questionInd];
      },
      error: (err, st) {},
      loading: () {},
    );
    final isCorrectItem = response == question.answer;

    return Expanded(
      flex: 5,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            color: AppColors.fourthColor,
            height: constraints.maxHeight,
            child: questionNum > 0
                ? SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.zero,
                                child: Wrap(
                                  runSpacing: 20,
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 32,
                                      width: 32,
                                      child: isCorrectItem
                                          ? const CorrectnessIcon(
                                              isCorrect: true,
                                              padding: EdgeInsets.all(4),
                                            )
                                          : const CorrectnessIcon(
                                              isCorrect: false,
                                              padding: EdgeInsets.all(4),
                                            ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'Question $questionNum',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 32),
                                    ),
                                    const SizedBox(width: 12),
                                    Flexible(
                                      child: IntrinsicWidth(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 12,
                                            horizontal: 12,
                                          ),
                                          decoration: BoxDecoration(
                                            color: getCategoryColor(
                                                question.category),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              question.category,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                child: Text(
                                  question.question,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ),
                              question.image != null
                                  ? Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 0, 20),
                                      child: Image.network(
                                        question.image!.contains(baseUrl)
                                            ? question.image!
                                            : baseUrl + question.image!,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const SizedBox(height: 20),
                              const Text(
                                'Choices:',
                                style: TextStyle(fontSize: 20),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: question.choices.length,
                                itemBuilder: (context, index) {
                                  return Text(
                                    '${choiceLetters[index]} ${question.choices[index]}',
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Correct Answer: ${question.answer.toString().toUpperCase()}',
                                style: const TextStyle(fontSize: 20),
                              ),
                              response != null
                                  ? Text(
                                      'Your Answer: ${response.toUpperCase()}',
                                      style: const TextStyle(fontSize: 20),
                                    )
                                  : const SizedBox(),
                              const SizedBox(height: 20),
                              question.solution != null &&
                                      question.solution.isNotEmpty
                                  ? Text(
                                      'Explanation: ${question.solution}',
                                      style: const TextStyle(fontSize: 20),
                                    )
                                  : const SizedBox(),
                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          );
        },
      ),
    );
  }
}
