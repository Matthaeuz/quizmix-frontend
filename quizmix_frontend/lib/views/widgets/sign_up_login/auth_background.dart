import 'package:flutter/material.dart';
import 'package:quizmix_frontend/views/screens/login_screen.dart';
import 'package:quizmix_frontend/views/screens/signup_screen.dart';
import 'package:quizmix_frontend/views/widgets/elevated_button.dart';

class AuthBackground extends StatelessWidget {
  final bool isLoginScreen;

  const AuthBackground({super.key, required this.isLoginScreen});

  @override
  Widget build(BuildContext context) {
    final navigatedScreen = isLoginScreen ? const SignupScreen() : const LoginScreen();

    return Expanded(
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
                    text: isLoginScreen ? 'Sign Up' : 'Login',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => navigatedScreen));
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
