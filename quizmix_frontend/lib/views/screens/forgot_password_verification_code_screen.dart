import 'package:flutter/material.dart';
import 'package:quizmix_frontend/views/screens/login_screen.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:pinput/pinput.dart';

class ForgotPasswordVerificationCodeScreen extends StatelessWidget {
  const ForgotPasswordVerificationCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const LoginScreen(),
        Container(
          color: const Color(0x800077B6),
        ),
        Scaffold(
          appBar: null,
          backgroundColor: Colors.transparent,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: IntrinsicHeight(
                child: Container(
                  width: 600,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'A verification code has been sent to A*****1@gmail.com. Input the verification code here:',
                          style: TextStyle(
                            fontSize: 18,
                            color:
                                AppColors.mainColor, // Replace with your color
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: Pinput(
                            length: 6,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            defaultPinTheme: PinTheme(
                              height: 150.0,
                              width: 150.0,
                              // textStyle: GoogleFonts.urbanist(
                              //   fontSize: 24.0,
                              //   color: Colors.black,
                              //   fontWeight: FontWeight.w700,
                              // ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.5),
                                  width: 1.0,
                                ),
                              ),
                            ),
                            focusedPinTheme: PinTheme(
                              height: 60.0,
                              width: 60.0,
                              // textStyle: GoogleFonts.urbanist(
                              //   fontSize: 24.0,
                              //   color: Colors.black,
                              //   fontWeight: FontWeight.w700,
                              // ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SolidButton(
                              text: 'Cancel',
                              width: 200,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            const SizedBox(width: 25),
                            SolidButton(
                              text: 'Continue',
                              width: 200,
                              onPressed: () {
                                // TODO: Implement continue functionality
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
