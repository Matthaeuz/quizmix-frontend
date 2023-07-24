import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/utils/sign_up.helper.dart';
import 'package:quizmix_frontend/state/models/users/signup_details.dart';
import 'package:quizmix_frontend/views/screens/login_screen.dart';
import 'package:quizmix_frontend/views/widgets/sign_up_login/text_field.dart';
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
                    'Sign up',
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
                  labelText: 'First Name',
                  obscureText: false,
                  controller: firstNameController,
                ),
                const SizedBox(height: 16.0),
                TextFieldWidget(
                  labelText: 'Middle Name',
                  obscureText: false,
                  controller: middleNameController,
                ),
                const SizedBox(height: 16.0),
                TextFieldWidget(
                  labelText: 'Last Name',
                  obscureText: false,
                  controller: lastNameController,
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
                const SizedBox(height: 40.0),
                SolidButton(
                  text: 'Create account',
                  onPressed: () {
                    SignUpDetails details = SignUpDetails(
                      email: emailController.text.toLowerCase(),
                      firstName: firstNameController.text,
                      lastName: lastNameController.text,
                      password: passwordController.text,
                    );

                    if (middleNameController.text.isNotEmpty) {
                      details.middleName = middleNameController.text;
                    }

                    signUp(details, ref).then((value) => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()))
                        });
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
