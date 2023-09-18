import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/utils/sign_in.helper.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/auth/auth_details.dart';
import 'package:quizmix_frontend/state/providers/ui/login_state_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/tab_state_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewee/reviewee_home_screen.dart';
import 'package:quizmix_frontend/views/screens/reviewer/reviewer_home_screen.dart';
import 'package:quizmix_frontend/views/widgets/outlined_button.dart';
import 'package:quizmix_frontend/views/widgets/sign_up_login/text_field.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class LoginFields extends ConsumerStatefulWidget {
  const LoginFields({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginFieldsState();
}

class _LoginFieldsState extends ConsumerState<LoginFields> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginStateProvider);

    if (loginState == LoginState.loggingIn) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 48.0,
            width: 48.0,
            child: CircularProgressIndicator(strokeWidth: 6.0),
          ),
          SizedBox(height: 16.0),
          Text(
            'Logging in...',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: AppColors.mainColor,
            ),
          ),
        ],
      );
    }

    return Align(
      alignment: Alignment.center,
      child: FractionallySizedBox(
        widthFactor: 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                'Login',
                style: TextStyle(fontSize: 64.0),
              ),
            ),
            const Center(
              child: SizedBox(
                width: 280.0,
                child: Text(
                  'Let’s get started with your QuizMix Code journey!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFieldWidget(
              labelText: 'Email',
              obscureText: false,
              controller: emailController,
            ),
            const SizedBox(height: 16.0),
            TextFieldWidget(
              labelText: 'Password',
              obscureText: true,
              controller: passwordController,
            ),
            const SizedBox(height: 8.0),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  ref
                      .read(modalStateProvider.notifier)
                      .updateModalState(ModalState.forgotPassword);
                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.centerRight,
                  foregroundColor: AppColors.mainColor,
                ),
                child: const Text('Forgot Password'),
              ),
            ),
            const SizedBox(height: 40.0),
            SolidButton(
              text: 'Login',
              onPressed: () async {
                if (emailController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  ref
                      .read(loginStateProvider.notifier)
                      .updateLoginState(LoginState.loggingIn);

                  AuthDetails details = AuthDetails(
                    email: emailController.text.toLowerCase(),
                    password: passwordController.text,
                  );

                  await signIn(details, ref).then((role) {
                    if (role == 'reviewer') {
                      ref
                          .read(tabStateProvider.notifier)
                          .updateTabState(TabState.reviewerDashboard);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ReviewerHomeScreen()));
                    } else {
                      ref
                          .read(tabStateProvider.notifier)
                          .updateTabState(TabState.revieweeQuizzes);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RevieweeHomeScreen()));
                    }
                    ref
                        .read(loginStateProvider.notifier)
                        .updateLoginState(LoginState.loginScreen);
                  }, onError: (error, stackTrace) {
                    ref
                        .read(loginStateProvider.notifier)
                        .updateLoginState(LoginState.loginScreen);
                  });
                }
              },
            ),
            const SizedBox(height: 16.0),
            ButtonOutlined(
              text: 'Sign Up',
              onPressed: () {
                ref
                    .read(loginStateProvider.notifier)
                    .updateLoginState(LoginState.signUpScreen);
              },
            ),
          ],
        ),
      ),
    );
  }
}
