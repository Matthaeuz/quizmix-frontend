import 'package:flutter/material.dart';
import 'package:quizmix_frontend/views/screens/reviewer/view_quiz_screen.dart';
/// Remember to remove this screen later.
class DashboardItemListContainer extends StatelessWidget {
  final String myQuizzesText;
  final bool useImages;

  const DashboardItemListContainer({
    Key? key,
    required this.myQuizzesText,
    this.useImages = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> quizData = [
      {'title': 'Algorithms and Programming Quiz'},
      {'title': 'This is my quiz'},
      {'title': 'My first Quiz'},
      {'title': 'Basic quiz'},
      {'title': 'Basic quiz'},
      {'title': 'Basic quiz'},
      {'title': 'Basic quiz'},
      {'title': 'Basic quiz'},
    ];

    final List<Map<String, String>> reviewees = [
      {
        'name': 'Alcuitas, Aaron Benjmin',
        'profile_picture': 'lib/assets/images/profile_pictures/aaron.jpg'
      },
      {
        'name': 'Alunan, Ron Matthew',
        'profile_picture': 'lib/assets/images/profile_pictures/aaron.jpg'
      },
      {
        'name': 'Adaya, Jerico Jan',
        'profile_picture': 'lib/assets/images/profile_pictures/aaron.jpg'
      },
      {
        'name': 'Lim, Garfield Greg',
        'profile_picture': 'lib/assets/images/profile_pictures/aaron.jpg'
      },
      {
        'name': 'Tenerife, Jillian Joy',
        'profile_picture': 'lib/assets/images/profile_pictures/aaron.jpg'
      },
      {
        'name': 'Sumampong, Alloyd',
        'profile_picture': 'lib/assets/images/profile_pictures/aaron.jpg'
      },
      {
        'name': 'Cumayas, Jerick',
        'profile_picture': 'lib/assets/images/profile_pictures/aaron.jpg'
      },
      {
        'name': 'Nabua, Edvil Clark',
        'profile_picture': 'lib/assets/images/profile_pictures/aaron.jpg'
      },
    ];

    return Column(
      children: [
        // First Row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              myQuizzesText,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF03045E),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Handle View All onPress
              },
              child: const Text(
                'View All',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        // Second Row
        SizedBox(
          height: 200,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  width: 200,
                  height: 200,
                  color: Colors.white,
                  child: const Icon(Icons.add, size: 100, color: Colors.black),
                ),
                const SizedBox(width: 25),
                ...quizData.asMap().entries.map((entry) {
                  final int index = entry.key;
                  final Map<String, String> quiz = entry.value;
                  final String title = useImages ? '' : quiz['title']!;
                  final String firstLetter = title.isNotEmpty ? title[0] : '';
                  final String name =
                      useImages ? reviewees[index]['name']! : '';

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ViewQuizScreen()));
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      color: Colors.white,
                      margin: const EdgeInsets.only(right: 25),
                      padding: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.center,
                                child: useImages
                                    ? Image.asset(
                                        reviewees[index]['profile_picture']!,
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )
                                    : Text(
                                        firstLetter.toUpperCase(),
                                        style: const TextStyle(
                                          fontSize: 50,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  useImages ? name : title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
