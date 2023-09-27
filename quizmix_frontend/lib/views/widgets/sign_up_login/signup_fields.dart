import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/utils/sign_up.helper.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/users/signup_details.dart';
import 'package:quizmix_frontend/state/providers/ui/login_state_provider.dart';
import 'package:quizmix_frontend/views/widgets/text_field.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class SignUpFields extends ConsumerStatefulWidget {
  const SignUpFields({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpFieldsState();
}

class _SignUpFieldsState extends ConsumerState<SignUpFields> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginStateProvider);

    if (loginState == LoginState.signingUp) {
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
            'Creating account...',
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
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  ref
                      .read(loginStateProvider.notifier)
                      .updateLoginState(LoginState.loginScreen);
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
                    Text('Back to Login'),
                  ],
                ),
              ),
            ),
            const Center(
              child: Text(
                'Sign up',
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
              labelText: 'First Name',
              controller: firstNameController,
            ),
            const SizedBox(height: 16.0),
            TextFieldWidget(
              labelText: 'Middle Name',
              controller: middleNameController,
            ),
            const SizedBox(height: 16.0),
            TextFieldWidget(
              labelText: 'Last Name',
              controller: lastNameController,
            ),
            const SizedBox(height: 16.0),
            TextFieldWidget(
              labelText: 'Email',
              controller: emailController,
            ),
            const SizedBox(height: 16.0),
            TextFieldWidget(
              labelText: 'Password',
              obscureText: true,
              controller: passwordController,
            ),
            const SizedBox(height: 16.0),
            SolidButton(
              text: 'Create account',
              onPressed: () async {
                if (emailController.text.isNotEmpty &&
                    firstNameController.text.isNotEmpty &&
                    lastNameController.text.isNotEmpty &&
                    passwordController.text.isNotEmpty) {
                  ref
                      .read(loginStateProvider.notifier)
                      .updateLoginState(LoginState.signingUp);

                  SignUpDetails details = SignUpDetails(
                    email: emailController.text.toLowerCase(),
                    firstName: firstNameController.text,
                    lastName: lastNameController.text,
                    password: passwordController.text,
                  );

                  if (middleNameController.text.isNotEmpty) {
                    details.middleName = middleNameController.text;
                  }

                  await signUp(details, ref).then(
                      (value) => {
                            ref
                                .read(loginStateProvider.notifier)
                                .updateLoginState(LoginState.loginScreen)
                          }, onError: (error, stackTrace) {
                    ref
                        .read(loginStateProvider.notifier)
                        .updateLoginState(LoginState.signUpScreen);
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
