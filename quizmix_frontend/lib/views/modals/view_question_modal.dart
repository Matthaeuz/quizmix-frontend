import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/questions/current_question_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';

class ViewQuestionModal extends ConsumerStatefulWidget {
  const ViewQuestionModal({Key? key}) : super(key: key);

  @override
  ConsumerState<ViewQuestionModal> createState() => _ViewQuestionModalState();
}

class _ViewQuestionModalState extends ConsumerState<ViewQuestionModal> {
  @override
  Widget build(BuildContext context) {
    final currentQuestion = ref.watch(currentQuestionProvider);
    final choiceLetters = ['A', 'B', 'C', 'D'];

    return Scaffold(
      appBar: null,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: IntrinsicHeight(
            child: Container(
              width: 800,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        ref
                            .read(modalStateProvider.notifier)
                            .updateModalState(ModalState.none);
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
                          Text('Back to Question Bank'),
                        ],
                      ),
                    ),
                    currentQuestion != null
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 16),
                              Text(
                                'Question ${currentQuestion.id}',
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Category: ${currentQuestion.category.name}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                currentQuestion.question,
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 16),
                              currentQuestion.image != null
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: Image.network(
                                        currentQuestion.image!,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const SizedBox(),
                              for (var i = 0;
                                  i < currentQuestion.choices.length;
                                  i++) ...[
                                Text(
                                  '${choiceLetters[i]}. ${currentQuestion.choices[i]}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                              const SizedBox(height: 16),
                              Text(
                                'Answer: ${currentQuestion.answer.toUpperCase()}. ${currentQuestion.choices[choiceLetters.indexOf(currentQuestion.answer.toUpperCase())]}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              currentQuestion.solution != null &&
                                      currentQuestion.solution!.isNotEmpty
                                  ? Text(
                                      'Reviewer\'s Explanation: ${currentQuestion.solution}',
                                      style: const TextStyle(fontSize: 16),
                                    )
                                  : const SizedBox(),
                              const SizedBox(height: 16),
                            ],
                          )
                        : const Expanded(
                            child: Center(
                              child: EmptyDataPlaceholder(
                                message: "Please try again later",
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
