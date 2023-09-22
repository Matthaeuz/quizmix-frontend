import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';

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
            child: IntrinsicHeight(
              child: Container(
                width: 800,
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
