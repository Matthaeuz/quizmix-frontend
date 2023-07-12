import 'package:flutter/material.dart';
import 'package:quizmix_frontend/views/screens/LoginScreen.dart';

import 'views/screens/Reviewer/DashboardScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Name',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(), // Set the home property to LoginScreen
    );
  }
}
