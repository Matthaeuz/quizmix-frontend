import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/utils/sign_in.helper.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/auth/auth_details.dart';
import 'package:quizmix_frontend/views/screens/forgot_password_input_email_screen.dart';
import 'package:quizmix_frontend/views/screens/reviewee/my_quizzes_screen.dart';
import 'package:quizmix_frontend/views/screens/reviewer/dashboard_screen.dart';
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
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100.0),
        child: Align(
          alignment: Alignment.center,
          child: FractionallySizedBox(
            widthFactor: 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: const BoxDecoration(),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 64.0),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(),
                  child: const Text(
                    'Let’s get started with your QuizMix Code journey!',
                    style: TextStyle(fontSize: 24.0),
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
                Container(
                  decoration: const BoxDecoration(),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ForgotPasswordInputEmailScreen(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.mainColor,
                      alignment: Alignment.centerRight,
                    ),
                    child: const Text('Forgot Password'),
                  ),
                ),
                const SizedBox(height: 40.0),
                SolidButton(
                  text: 'Login',
                  onPressed: () {
                    AuthDetails details = AuthDetails(
                      email: emailController.text.toLowerCase(),
                      password: passwordController.text,
                    );

                    signIn(details, ref).then((value) => {
                          if (value == 'reviewer')
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DashboardScreen()))
                            }
                          else
                            {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const MyQuizzesScreen()))
                            }
                        });
                  },
                ),
                const SizedBox(height: 16.0),
                ButtonOutlined(
                  text: 'Sign in with Google',
                  onPressed: () {
                    // TODO: Implement sign in with Google functionality
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
