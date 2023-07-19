import 'package:flutter/material.dart';
import 'package:quizmix_frontend/views/screens/reviewer/view_question_bank_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
      home: ViewQuestionBankScreen(),
    );
  }
}
