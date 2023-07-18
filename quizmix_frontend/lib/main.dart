import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/views/screens/LoginScreen.dart';
// import 'package:quizmix_frontend/views/screens/Reviewer/AddQuestionScreen.dart';
// import 'package:quizmix_frontend/views/screens/Reviewer/UpdateQuizBankDetailsScreen.dart';
// import 'package:quizmix_frontend/views/screens/Reviewer/UpdateQuizBankScreen.dart';
// import 'package:quizmix_frontend/views/screens/Reviewer/UploadedQuestionsScreen.dart';
// import 'views/screens/Reviewer/DashboardScreen.dart';
// import 'views/screens/Reviewer/ViewQuestionBankScreen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuizMix Code',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginScreen(),
    );
  }
}
