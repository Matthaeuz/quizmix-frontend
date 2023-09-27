import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/utils/multipart_form_handlers/retrain_model.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/file_picker/dataset_file_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/process_state_provider.dart';
import 'package:quizmix_frontend/views/widgets/dataset_input_button.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class RetrainModelModal extends ConsumerStatefulWidget {
  const RetrainModelModal({Key? key}) : super(key: key);

  @override
  RetrainModelModalState createState() => RetrainModelModalState();
}

class RetrainModelModalState extends ConsumerState<RetrainModelModal> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            // child: IntrinsicHeight(
            child: Container(
              width: 380,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Container(
                padding: const EdgeInsets.all(24.0),
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
                    const Text(
                      "Retrain Model",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Note: Please upload only .csv and .xlsx files, with 2 columns question and label.",
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 24),
                    const Center(child: DatasetInputButton()),
                    const SizedBox(height: 24),
                    Center(
                        child: SolidButton(
                            text: 'Retrain QuizMix',
                            width: 160,
                            icon: const Icon(Icons.play_circle_outline),
                            onPressed: () async {
                              final datasetPath =
                                  ref.read(datasetFileProvider).state;
                              if (datasetPath != null) {
                                ref
                                    .read(processStateProvider.notifier)
                                    .updateProcessState(ProcessState.loading);
                                retrainModel(datasetPath, ref).then(
                                  (value) {
                                    ref
                                        .read(processStateProvider.notifier)
                                        .updateProcessState(ProcessState.done);
                                  },
                                  onError: (error) {
                                    ref
                                        .read(processStateProvider.notifier)
                                        .updateProcessState(ProcessState.done);
                                    ref
                                        .read(modalStateProvider.notifier)
                                        .updateModalState(ModalState.none);
                                  },
                                );
                              }
                            }))
                  ],
                ),
              ),
            ),
            // ),
          ),
        ),
      ),
    );
  }
}
