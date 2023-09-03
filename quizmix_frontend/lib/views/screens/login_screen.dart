import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/ui/login_state_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/views/modals/forgot_password_modal.dart';
import 'package:quizmix_frontend/views/widgets/sign_up_login/login_fields.dart';
import 'package:quizmix_frontend/views/widgets/sign_up_login/signup_fields.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  static const BoxConstraints logoBoxConstraints = BoxConstraints(
    minWidth: 240.0,
    minHeight: 240.0,
    maxHeight: 400.0,
    maxWidth: 400.0,
  );
  static const BoxConstraints loginBoxConstraintsA = BoxConstraints(
    minWidth: 400.0,
    minHeight: 800.0,
    maxHeight: 800.0,
    maxWidth: 600.0,
  );
  static const BoxConstraints loginBoxConstraintsB = BoxConstraints(
    minWidth: 400.0,
    minHeight: 600.0,
    maxWidth: 600.0,
  );

  Widget getWidgetFromLoginState(LoginState loginState) {
    if (loginState == LoginState.loginScreen ||
        loginState == LoginState.loggingIn) {
      return const LoginFields();
    } else if (loginState == LoginState.signUpScreen ||
        loginState == LoginState.signingUp) {
      return const SignUpFields();
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginStateProvider);
    final modalState = ref.watch(modalStateProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double logoContainerWidth = screenWidth * 0.3;

    return Stack(
      children: [
        Scaffold(
          appBar: null,
          body: SingleChildScrollView(
            child: Container(
              width: screenWidth,
              color: AppColors.secondaryColor,
              padding: EdgeInsets.fromLTRB(
                  0, screenHeight * 0.05, 0, screenHeight * 0.05),
              child: Wrap(
                spacing: 24,
                runSpacing: 8,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Container(
                    width: logoContainerWidth,
                    height: logoContainerWidth,
                    constraints: logoBoxConstraints,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double parentWidth = constraints.maxWidth;

                        return Column(
                          children: [
                            Container(
                              width: parentWidth * 0.7,
                              height: parentWidth * 0.7,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 16,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                              child: const Image(
                                image: AssetImage(
                                    'lib/assets/images/QuizMix_Logo.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                            SizedBox(height: parentWidth * 0.05),
                            RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: screenWidth < 1080 ? 32.0 : 48.0,
                                  fontWeight: FontWeight.bold,
                                ),
                                children: const <TextSpan>[
                                  TextSpan(
                                    text: 'QuizMix',
                                    style: TextStyle(
                                      color: AppColors.white,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 8.0,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' Code',
                                    style: TextStyle(
                                      color: AppColors.iconColor,
                                      shadows: <Shadow>[
                                        Shadow(
                                          offset: Offset(2.0, 2.0),
                                          blurRadius: 8.0,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    width: screenWidth * 0.5,
                    height: screenHeight * 0.9,
                    constraints: screenHeight >= loginBoxConstraintsA.minHeight
                        ? loginBoxConstraintsA
                        : loginBoxConstraintsB,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: getWidgetFromLoginState(loginState),
                  )
                ],
              ),
            ),
          ),
        ),
        if (modalState == ModalState.forgotPassword) ...[
          Container(
            color: AppColors.fourthColor.withOpacity(0.8),
            child: const ForgotPasswordModal(),
          ),
        ]
      ],
    );
  }
}
