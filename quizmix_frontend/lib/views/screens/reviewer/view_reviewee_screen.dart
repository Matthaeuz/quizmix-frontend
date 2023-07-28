import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';

class ViewRevieweeScreen extends StatelessWidget {
  ViewRevieweeScreen({Key? key}) : super(key: key);

  // Define the data for quiz names and scores
  final List<Map<String, String>> quizData = [
    {
      'quizName': 'Quiz 5',
      'totalScore': '80%',
    },
    {
      'quizName': 'Quiz 4',
      'totalScore': '90%',
    },
    {
      'quizName': 'Quiz 3',
      'totalScore': '70%',
    },
    {
      'quizName': 'Quiz 2',
      'totalScore': '80%',
    },
    {
      'quizName': 'Quiz 1',
      'totalScore': '70%',
    },
    // Add more quiz data as needed...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Row(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Circle Picture
                  const CircleAvatar(
                    radius: 90,
                    backgroundImage:
                        AssetImage("lib/assets/images/default_pic.png"),
                  ),
                  const SizedBox(height: 25),
                  // Name
                  const Text(
                    "Aaron Benjmin Alcuitas",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),
                  // Your Quizzes
                  Expanded(
                      child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        margin: const EdgeInsets.only(bottom: 50),
                        decoration: BoxDecoration(
                          color: AppColors.fifthColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Reviewee History',
                                style: TextStyle(
                                  fontSize: 28,
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const Padding(
                                  padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Quiz Name',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Score',
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                              const SizedBox(height: 8),
                              // List of Quiz Items
                              ListView.builder(
                                shrinkWrap: true,
                                itemCount: 5,
                                itemBuilder: (context, index) {
                                  final quizName = quizData[index]['quizName'];
                                  final totalScore =
                                      quizData[index]['totalScore'];

                                  return Column(
                                    children: [
                                      Container(
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                25, 0, 25, 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  flex: 3,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        quizName!,
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        totalScore!,
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                      const SizedBox(
                                        height: 12,
                                      )
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
