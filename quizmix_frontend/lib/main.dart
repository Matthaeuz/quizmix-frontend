import 'package:flutter/material.dart';
import 'package:quizmix_frontend/views/screens/LoginScreen.dart';
import 'package:quizmix_frontend/views/screens/SignupScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignupScreen(), // Set the home property to LoginScreen
    );
  }
}
