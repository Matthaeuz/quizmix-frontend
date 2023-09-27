import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/views/widgets/text_field.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class ForgotPasswordModal extends ConsumerStatefulWidget {
  const ForgotPasswordModal({Key? key}) : super(key: key);

  @override
  ForgotPasswordModalState createState() => ForgotPasswordModalState();
}

class ForgotPasswordModalState extends ConsumerState<ForgotPasswordModal> {
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
                width: 600,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Forgot Password',
                        style: TextStyle(fontSize: 24),
                      ),
                      const SizedBox(height: 16),
                      TextFieldWidget(
                        labelText: 'Email',
                        controller: emailController,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SolidButton(
                            text: 'Cancel',
                            width: 160,
                            onPressed: () {
                              ref
                                  .read(modalStateProvider.notifier)
                                  .updateModalState(ModalState.none);
                            },
                          ),
                          const SizedBox(width: 16),
                          SolidButton(
                            text: 'Continue',
                            width: 160,
                            onPressed: () {
                              // TODO: Implement continue functionality
                            },
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
      ),
    );
  }
}
