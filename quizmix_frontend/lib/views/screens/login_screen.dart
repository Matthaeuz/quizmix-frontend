import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key});

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
                                    'Login',
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
                                Container(
                                  decoration: const BoxDecoration(
                                      // border: Border.all(width: 1.0),
                                      ),
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Container(
                                  decoration: const BoxDecoration(
                                      // border: Border.all(width: 1.0),
                                      ),
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                    ),
                                    obscureText: true,
                                  ),
                                ),
                                const SizedBox(height: 8.0),
                                Container(
                                  decoration: const BoxDecoration(
                                      // border: Border.all(width: 1.0),
                                      ),
                                  child: TextButton(
                                    onPressed: () {
                                      // TODO: Implement forgot password functionality
                                    },
                                    style: TextButton.styleFrom(
                                      alignment: Alignment
                                          .centerRight, // Align text to the right
                                      primary:
                                          const Color(0xFF03045E), // Text color
                                    ),
                                    child: const Text('Forgot Password'),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Container(
                                  decoration: const BoxDecoration(
                                      // border: Border.all(width: 1.0),
                                      ),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      // TODO: Implement login functionality
                                    },
                                    style: ElevatedButton.styleFrom(
                                      foregroundColor: Colors.white,
                                      backgroundColor:
                                          const Color(0xFF03045E), // Text color
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            50.0), // Border radius
                                      ),
                                      fixedSize: const Size.fromHeight(
                                          50.0), // Button height
                                    ),
                                    child: const Text('Login', style: TextStyle(fontSize: 16),),
                                  ),
                                ),
                                const SizedBox(height: 16.0),
                                Container(
                                  decoration: const BoxDecoration(
                                      // border: Border.all(width: 1.0),
                                      ),
                                  child: OutlinedButton(
                                    onPressed: () {
                                      // TODO: Implement sign in with Google functionality
                                    },
                                    style: OutlinedButton.styleFrom(
                                      foregroundColor: const Color(0xFF333333),
                                      backgroundColor:
                                          Colors.white, // Text color
                                      side: const BorderSide(
                                        color:
                                            Color(0xFF3A0CA3), // Border color
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            50.0), // Border radius
                                      ),
                                      minimumSize: const Size.fromHeight(
                                          50.0), // Button height
                                    ),
                                    child: const Text('Sign in with Google', style: TextStyle(fontSize: 16),),
                                  ),
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
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 25.0,
                      right: 25.0,
                      child: ElevatedButton(
                        onPressed: () {
                          // TODO: Implement signup functionality
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          primary: Color(0xFF03045E), // Text color
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20.0), // Border radius
                          ),
                          minimumSize: Size(50.0, 50.0), // Button size
                        ),
                        child: const Text(
                          'Sign up',
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ),
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
