import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/providers/questions/current_question_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class ViewQuestionModal extends ConsumerStatefulWidget {
  const ViewQuestionModal({Key? key}) : super(key: key);

  @override
  ConsumerState<ViewQuestionModal> createState() => _ViewQuestionModalState();
}

class _ViewQuestionModalState extends ConsumerState<ViewQuestionModal> {
  @override
  Widget build(BuildContext context) {
    final currentQuestion = ref.watch(currentQuestionProvider);

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
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: currentQuestion != null
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Question ${currentQuestion.id}',
                                      style: const TextStyle(fontSize: 32),
                                    ),
                                    const SizedBox(width: 15),
                                    Flexible(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                          horizontal: 12,
                                        ),
                                        child: Text(
                                          currentQuestion.category.name,
                                          style: const TextStyle(
                                            fontSize: 16,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Image.network(
                                  currentQuestion.image!,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'The correct answer is "${currentQuestion.answer}"',
                                  style: const TextStyle(fontSize: 28),
                                ),
                                const SizedBox(height: 20),
                                const Text(
                                  'Explanation:',
                                  style: TextStyle(fontSize: 28),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  currentQuestion.solution == ''
                                      ? 'No explanation available'
                                      : currentQuestion.solution!,
                                  style: const TextStyle(fontSize: 20),
                                ),
                              ],
                            )
                          : Container(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 1,
                          child: SolidButton(
                            text: "Back",
                            onPressed: () {
                              ref
                                  .read(modalStateProvider.notifier)
                                  .updateModalState(ModalState.none);
                            },
                          ),
                        ),
                      ],
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
