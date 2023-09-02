import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/views/widgets/sign_up_login/auth_background.dart';
import 'package:quizmix_frontend/views/widgets/sign_up_login/login_fields.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    // print('$screenWidth $screenHeight');

    // return Scaffold(
    //   appBar: null,
    //   body: Row(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       // Left Section
    //       Expanded(
    //         child: Padding(
    //           padding: const EdgeInsets.all(25),
    //           child: Container(
    //             decoration: const BoxDecoration(),
    //             child: const Column(
    //               mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Row(
    //                   children: [
    //                     Padding(
    //                       padding: EdgeInsets.only(right: 8.0),
    //                       child: Image(
    //                         image: AssetImage(
    //                             'lib/assets/images/QuizMix_Logo.png'),
    //                         height: 24.0,
    //                         width: 24.0,
    //                       ),
    //                     ),
    //                     Text(
    //                       'QuizMix Code',
    //                       style: TextStyle(fontSize: 18.0),
    //                     ),
    //                   ],
    //                 ),
    //                 LoginFields()
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //       // Right Section
    //       const AuthBackground(isLoginScreen: true)
    //     ],
    //   ),
    // );
    return Scaffold(
      appBar: null,
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          padding: EdgeInsets.fromLTRB(
              0, screenHeight * 0.05, 0, screenHeight * 0.05),
          child: Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Container(
                width: screenWidth * 0.3,
                height: screenWidth * 0.3,
                color: Colors.purple,
                constraints: logoBoxConstraints,
              ),
              Container(
                width: screenWidth * 0.5,
                height: screenHeight * 0.9,
                color: Colors.yellow,
                constraints: screenHeight >= loginBoxConstraintsA.minHeight
                    ? loginBoxConstraintsA
                    : loginBoxConstraintsB,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
