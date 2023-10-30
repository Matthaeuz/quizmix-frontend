import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/utils/forgot_password.helper.dart';
import 'package:quizmix_frontend/state/providers/forgot_password/current_email_provider.dart';
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
                          buildVerifyCodePage(context, ref), // Step 2
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
    final TextEditingController emailController = TextEditingController();
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
                }).catchError((e) {
                  ref
                      .read(processStateProvider.notifier)
                      .updateProcessState(ProcessState.done);
                });
              },
            ),
          ],
        )
      ],
    );
  }

  Widget buildVerifyCodePage(BuildContext context, WidgetRef ref) {
    final TextEditingController verificationCodeController =
        TextEditingController();
    final processState = ref.watch(processStateProvider);
    final email = ref.read(currentEmailProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFieldWidget(
          labelText: 'Enter Verification code here...',
          controller: verificationCodeController,
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SolidButton(
              text: 'Resend Code',
              width: 160,
              onPressed: () {
                ref
                    .read(processStateProvider.notifier)
                    .updateProcessState(ProcessState.loading);

                sendCode(email, ref).then((value) {
                  ref
                      .read(processStateProvider.notifier)
                      .updateProcessState(ProcessState.done);
                }).catchError((e) {
                  ref
                      .read(processStateProvider.notifier)
                      .updateProcessState(ProcessState.done);
                });
              },
            ),
            const SizedBox(width: 16),
            SolidButton(
              text: 'Previous',
              width: 160,
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
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
                final code = verificationCodeController.text;
                // verify code
                verifyCode(email, code, ref).then((value) {
                  ref
                      .read(processStateProvider.notifier)
                      .updateProcessState(ProcessState.done);
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }).catchError((e) {
                  ref
                      .read(processStateProvider.notifier)
                      .updateProcessState(ProcessState.done);
                });
              },
            ),
          ],
        )
      ],
    );
  }

  Widget buildChangePasswordPage(BuildContext context, WidgetRef ref) {
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmNewPasswordController =
        TextEditingController();
    final processState = ref.watch(processStateProvider);
    final email = ref.read(currentEmailProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFieldWidget(
          labelText: 'New Password',
          controller: newPasswordController,
        ),
        const SizedBox(height: 8),
        TextFieldWidget(
          labelText: 'Confirm New Password',
          controller: confirmNewPasswordController,
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SolidButton(
              text: 'Previous',
              width: 160,
              onPressed: () {
                pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
            ),
            const SizedBox(width: 16),
            ResponsiveSolidButton(
              text: processState == ProcessState.loading
                  ? 'Loading...'
                  : 'Change Password',
              width: 160,
              isUnpressable: processState == ProcessState.loading,
              condition: true,
              onPressed: () async {
                // send verification code and move on to next
                ref
                    .read(processStateProvider.notifier)
                    .updateProcessState(ProcessState.loading);

                sendCode(email, ref).then((value) {
                  ref
                      .read(processStateProvider.notifier)
                      .updateProcessState(ProcessState.done);
                  pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                }).catchError((e) {
                  ref
                      .read(processStateProvider.notifier)
                      .updateProcessState(ProcessState.done);
                });
              },
            ),
          ],
        )
      ],
    );
  }
}
