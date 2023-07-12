import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Side - Dashboard
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  // Profile Area
                  Container(
                    padding: const EdgeInsets.all(25),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Circular Picture
                        CircleAvatar(
                          radius: 30,
                          // backgroundImage:
                          //     AssetImage('assets/images/ProfilePicture.jpg'),
                        ),
                        SizedBox(width: 16),
                        // Text Information
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Aloysius Matthew A. Beronque',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'aloysiusmatthew1@gmail.com',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Dashboard Options
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        color: const Color(0xFF03045E),
                        child: ListTile(
                          leading: const Icon(
                            Icons.dashboard,
                            color: Colors.white,
                          ),
                          title: const Text(
                            'Dashboard',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          onTap: () {
                            // Handle Dashboard press
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading:
                            const Icon(Icons.person, color: Color(0xFF03045E)),
                        title: const Text(
                          'Reviewees',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF03045E)),
                        ),
                        onTap: () {
                          // Handle Reviewees press
                        },
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading: const Icon(Icons.quiz, color: Color(0xFF03045E)),
                        title: const Text(
                          'Quizzes',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold,
                              color: Color(0xFF03045E)),
                        ),
                        onTap: () {
                          // Handle Quizzes press
                        },
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        leading: const Icon(Icons.question_answer, color: Color(0xFF03045E)),
                        title: const Text(
                          'QuestionBank',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold,
                              color: Color(0xFF03045E)),
                        ),
                        onTap: () {
                          // Handle QuestionBank press
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Right Side - Background Color
          Expanded(
            flex: 8,
            child: Container(
              color: const Color(0xFFCAF0F8),
            ),
          ),
        ],
      ),
    );
  }
}
