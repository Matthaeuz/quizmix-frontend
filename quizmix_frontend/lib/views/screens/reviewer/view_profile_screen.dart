import 'package:flutter/material.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_quiz_item_container.dart';

class ViewProfileScreen extends StatelessWidget {
  const ViewProfileScreen({Key? key}) : super(key: key);

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
                    backgroundImage: AssetImage(
                      "lib/assets/images/profile_pictures/aloysius.jpg",
                    ),
                  ),
                  const SizedBox(height: 25),
                  // Name
                  const Text(
                    'Aloysius Matthew A. Beronque',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),
                  // Your Quizzes
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: const EdgeInsets.only(bottom: 50),
                      decoration: BoxDecoration(
                          color: const Color(0xFFCAF0F8),
                          borderRadius: BorderRadius.circular(16)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Your Quizzes',
                              style: TextStyle(
                                fontSize: 28,
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Quiz name',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Total Score',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: Container()),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            // Add your code for handling "See All" press here
                                          },
                                          child: const Row(
                                            children: [
                                              Text(
                                                'See All',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              Icon(
                                                Icons.arrow_drop_down,
                                                size: 24,
                                              ),
                                            ],
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            // Quiz Items
                            Expanded(
                              child: ListView.builder(
                                itemCount: 7,
                                itemBuilder: (context, index) {
                                  return Column(children: [
                                    ReviewerQuizItemContainer(
                                      quizName: 'Algorithms and Programming',
                                      totalScore: '80/80',
                                      onViewQuizPressed: () {
                                        // Add your code for "View Quiz" button pressed
                                      },
                                      onViewHistoryPressed: () {
                                        // Add your code for "View History" button pressed
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                  ]);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
