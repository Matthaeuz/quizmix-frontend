import 'package:flutter/material.dart';
import 'package:quizmix_frontend/views/screens/LoginScreen.dart';
import 'package:quizmix_frontend/views/screens/Reviewer/AddQuestionScreen.dart';
import 'package:quizmix_frontend/views/screens/Reviewer/UpdateQuizBankDetailsScreen.dart';
import 'package:quizmix_frontend/views/screens/Reviewer/UpdateQuizBankScreen.dart';
import 'package:quizmix_frontend/views/screens/Reviewer/UploadedQuestionsScreen.dart';
import 'views/screens/Reviewer/DashboardScreen.dart';
import 'views/screens/Reviewer/ViewQuestionBankScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}
