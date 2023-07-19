import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/auth/auth_details.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewee_details_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewer/dashboard_screen.dart';
import 'package:quizmix_frontend/views/screens/forgot_password_input_email_screen.dart';
import 'package:quizmix_frontend/views/screens/signup_screen.dart';
import 'package:quizmix_frontend/views/widgets/elevated_button.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';
import 'package:quizmix_frontend/views/widgets/outlined_button.dart';
import 'package:quizmix_frontend/views/widgets/Textfield.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Define Rest Client and Dio
    final client = ref.watch(restClientProvider);

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
                                  controller: emailController,
                                ),
                                const SizedBox(height: 16.0),
                                TextFieldWidget(
                                  labelText: 'Password',
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
                                      foregroundColor: const Color(0xFF03045E),
                                      alignment: Alignment.centerRight,
                                    ),
                                    child: const Text('Forgot Password'),
                                  ),
                                ),
                                const SizedBox(height: 40.0),
                                ButtonSolid(
                                  text: 'Login',
                                  onPressed: () async {
                                    AuthDetails details = AuthDetails(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );

                                    // Get a token if user credentials are valid and save it
                                    final token = await client.signIn(details);
                                    ref.read(authTokenProvider.notifier).updateToken(token);
                                    
                                    debugPrint('access: ${token.accessToken}');

                                    // Get user details and save to provider
                                    final user = await client.getUserByEmail(token.accessToken, emailController.text);
                                    
                                    final reviewee = await client.getRevieweeByUserId(token.accessToken, user[0].id);

                                    ref.read(revieweeProvider.notifier).updateReviewee(reviewee[0]);

                                    Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const DashboardScreen()));
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
                          text: 'Sign up',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupScreen(),
                              ),
                            );
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
