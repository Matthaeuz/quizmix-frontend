import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quizmix_frontend/views/widgets/ElevatedButton.dart';
import 'package:quizmix_frontend/views/widgets/SolidButton.dart';
import 'package:quizmix_frontend/views/widgets/OutlinedButton.dart';
import 'package:quizmix_frontend/views/widgets/Textfield.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key});

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
                decoration: const BoxDecoration(
                    // border: Border.all(width: 1.0),
                    ),
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
                                  decoration: const BoxDecoration(
                                      // border: Border.all(width: 1.0),
                                      ),
                                  child: const Text(
                                    'Sign up',
                                    style: TextStyle(fontSize: 64.0),
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                      // border: Border.all(width: 1.0),
                                      ),
                                  child: const Text(
                                    'Let’s get started with your QuizMix Code journey!',
                                    style: TextStyle(fontSize: 24.0),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                TextFieldWidget(
                                  labelText: 'Name',
                                ),
                                const SizedBox(height: 16.0),
                                TextFieldWidget(
                                  labelText: 'Email',
                                ),
                                const SizedBox(height: 16.0),
                                TextFieldWidget(
                                  labelText: 'Password',
                                ),
                                const SizedBox(height: 40.0),
                                ButtonSolid(
                                  text: 'Create account',
                                  onPressed: () {
                                    // TODO: Implement login functionality
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
              padding: EdgeInsets.all(25.0),
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
                          fit: BoxFit.none,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 25.0,
                        right: 25.0,
                        child: ButtonElevated(
                          text: 'Login',
                          onPressed: () {
                            // TODO: Implement signup functionality
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
