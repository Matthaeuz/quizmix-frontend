import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/utils/sign_up.helper.dart';
import 'package:quizmix_frontend/state/models/users/signup_details.dart';
import 'package:quizmix_frontend/views/widgets/elevated_button.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';
import 'package:quizmix_frontend/views/widgets/outlined_button.dart';
import 'package:quizmix_frontend/views/widgets/text_field.dart';
import 'package:quizmix_frontend/views/screens/login_screen.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({Key? key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Image(
                            image: AssetImage(
                                'lib/assets/images/QuizMix_Logo.png'),
                            height: 24.0,
                            width: 24.0,
                          ),
                        ),
                        Text(
                          'QuizMix Code',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                    Expanded(
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

                                    signUp(details, ref).then((value) => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginScreen()))
                                        });
                                  },
                                ),
                                const SizedBox(height: 16.0),
                                ButtonOutlined(
                                  text: 'Sign up with Google',
                                  onPressed: () {
                                    // TODO: Implement sign in with Google functionality
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Right Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Stack(
                  children: [
                    FractionallySizedBox(
                      widthFactor: 1.0,
                      heightFactor: 1.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          'lib/assets/images/Laptop.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 25.0,
                        right: 25.0,
                        child: ButtonElevated(
                          text: 'Login',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
