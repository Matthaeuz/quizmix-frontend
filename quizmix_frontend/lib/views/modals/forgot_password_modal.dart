import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/utils/forgot_password.helper.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/process_state_provider.dart';
import 'package:quizmix_frontend/views/widgets/responsive_solid_button.dart';
import 'package:quizmix_frontend/views/widgets/text_field.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class ForgotPasswordModal extends ConsumerStatefulWidget {
  const ForgotPasswordModal({Key? key}) : super(key: key);

  @override
  ForgotPasswordModalState createState() => ForgotPasswordModalState();
}

class ForgotPasswordModalState extends ConsumerState<ForgotPasswordModal> {
  final TextEditingController emailController = TextEditingController();
  final PageController pageController = PageController();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Container(
              width: 600,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Forgot Password',
                      style: TextStyle(fontSize: 24),
                    ),
                    SizedBox(
                      height: 160,
                      child: PageView(
                        controller: pageController,
                        onPageChanged: (index) {
                          setState(() {
                            currentPage = index;
                          });
                        },
                        children: [
                          buildSendCodePage(context, ref),
                          Placeholder(), // Step 2
                          Placeholder(), // Step 3
                          Placeholder(), // Step 4
                        ],
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

  Widget buildSendCodePage(BuildContext context, WidgetRef ref) {
    final processState = ref.watch(processStateProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
            ResponsiveSolidButton(
              text: processState == ProcessState.loading
                  ? 'Loading...'
                  : 'Continue',
              width: 160,
              isUnpressable: processState == ProcessState.loading,
              condition: true,
              onPressed: () async {
                // send verification code and move on to next
                ref
                    .read(processStateProvider.notifier)
                    .updateProcessState(ProcessState.loading);

                final String email = emailController.text;

                sendCode(email, ref).then((value) {
                  ref
                      .read(processStateProvider.notifier)
                      .updateProcessState(ProcessState.done);
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                });
              },
            ),
          ],
        )
      ],
    );
  }
}
