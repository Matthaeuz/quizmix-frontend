import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';
import 'package:quizmix_frontend/views/widgets/view_quiz_container.dart';
import 'dart:async';

class ViewQuizScreen extends StatefulWidget {
  const ViewQuizScreen({Key? key}) : super(key: key);

  @override
  State<ViewQuizScreen> createState() => _ViewQuizScreenState();
}

class _ViewQuizScreenState extends State<ViewQuizScreen> {
  final ScrollController _scrollController = ScrollController();

  Future<List<int>> getImageHeights() async {
    List<String> imagePaths = [
      'lib/assets/images/questions/q1.jpg',
      'lib/assets/images/questions/q2.jpg',
      'lib/assets/images/questions/q3.jpg',
      'lib/assets/images/questions/q4.jpg',
      'lib/assets/images/questions/q5.jpg',
    ];

    List<int> imageHeights = [];

    // Use Future.wait to wait for all the image loading operations to complete
    await Future.wait(
      imagePaths.map((path) {
        Image image = Image.network(path);
        Completer<int> completer = Completer<int>();

        image.image
            .resolve(const ImageConfiguration())
            .addListener(ImageStreamListener((info, call) {
          int height = info.image.height;
          completer
              .complete(height); // Complete the Future when the image is loaded
        }));

        return completer
            .future; // Return the Future for this image loading operation
      }),
    ).then((heights) {
      imageHeights =
          heights.cast<int>(); // Cast the list of dynamic to List<int>
    });

    return imageHeights;
  }

  List<double> listViewItemHeights = List.filled(5, 0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Area
          Expanded(
            flex: 1,
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  color: AppColors.lightBackgroundColor,
                  height: constraints.maxHeight,
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              color: Colors.white,
                              child: const Center(
                                child: Text(
                                  'A',
                                  style: TextStyle(
                                    fontSize: 60,
                                    color: AppColors.mainColor,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Algorithms and Programming',
                              style: TextStyle(fontSize: 24),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SolidButton(
                                  text: 'View Statistics',
                                  onPressed: () {
                                    getImageHeights();
                                  },
                                  icon: const Icon(Icons.bar_chart),
                                ),
                                const SizedBox(width: 25),
                                SolidButton(
                                  text: 'Regenerate',
                                  onPressed: () {
                                    // Add your code for handling "Regenerate" press here
                                  },
                                  icon: const Icon(Icons.refresh),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Questions',
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: Row(
                                children: [
                                  // Left Area
                                  Expanded(
                                    flex: 2,
                                    child: SizedBox(
                                      child: ListView.builder(
                                        controller: _scrollController,
                                        itemCount: 5,
                                        itemBuilder: (context, index) {
                                          final int questionNumber = index + 1;
                                          final String imageFileName =
                                              'q$questionNumber.jpg';
                                          return Column(
                                            children: [
                                              LayoutBuilder(
                                                builder:
                                                    (context, constraints) {
                                                  // Store the height of the current item
                                                  listViewItemHeights[index] =
                                                      constraints.maxHeight;
                                                  return Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                            AppColors.mainColor,
                                                        width: 1.0,
                                                      ),
                                                      color: Colors.white,
                                                    ),
                                                    padding:
                                                        const EdgeInsets.all(
                                                            12.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Question $questionNumber',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        ),
                                                        const SizedBox(
                                                            height: 8.0),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: AppColors
                                                                  .thirdColor,
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          child: Image.asset(
                                                            'lib/assets/images/questions/$imageFileName',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                },
                                              ),
                                              const SizedBox(
                                                height: 25,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 25,
                                  ),
                                  // Right Area
                                  // Right Area
                                  Expanded(
                                    child: FutureBuilder<List<int>>(
                                      future: getImageHeights(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        } else if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          List<int> imageHeights =
                                              snapshot.data ?? [];
                                          int numberOfItems = 5;

                                          const double defaultFontSize = 16.0;
                                          const double paddingSize = 12.0;
                                          const double spacing = 25.0;
                                          const double verticalBorders = 4;

                                          List<double> totalHeights =
                                              List.filled(numberOfItems, 0.0);
                                          double itemHeight = defaultFontSize +
                                              paddingSize * 2 +
                                              spacing +
                                              verticalBorders;

                                          for (int i = 1;
                                              i < numberOfItems;
                                              i++) {
                                            totalHeights[i] =
                                                totalHeights[i - 1] +
                                                    itemHeight;
                                            if (i - 1 < imageHeights.length) {
                                              totalHeights[i] +=
                                                  imageHeights[i - 1]
                                                      .toDouble();
                                              print('imageHeights[${i - 1}]');
                                              print(imageHeights[i - 1]);
                                            }
                                          }

                                          return Align(
                                            alignment: Alignment.topCenter,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: AppColors.mainColor,
                                                  width: 1.0,
                                                ),
                                                color: Colors.white,
                                              ),
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Expanded(
                                                child: LayoutBuilder(
                                                  builder:
                                                      (context, constraints) {
                                                    // Calculate the height and width based on percentage of the available space
                                                    double gridHeight =
                                                        constraints.maxHeight *
                                                            .5;
                                                    double gridWidth =
                                                        constraints.maxWidth *
                                                            .9;

                                                    return GridView.builder(
                                                      gridDelegate:
                                                          SliverGridDelegateWithFixedCrossAxisCount(
                                                        crossAxisCount: 5,
                                                        crossAxisSpacing: 8.0,
                                                        mainAxisSpacing: 12.0,
                                                        childAspectRatio:
                                                            gridWidth /
                                                                gridHeight,
                                                      ),
                                                      itemCount: 7,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Column(
                                                          children: [
                                                            Text(
                                                              '${index + 1}',
                                                              style:
                                                                  const TextStyle(
                                                                      fontSize:
                                                                          16),
                                                            ),
                                                            const SizedBox(
                                                              height: 6,
                                                            ),
                                                            Container(
                                                              height: 28,
                                                              width: 28,
                                                              color: AppColors
                                                                  .fifthColor, // Set the desired color
                                                              child:
                                                                  ElevatedButton(
                                                                onPressed: () {
                                                                  print(
                                                                      "Question ${index + 1} = ${totalHeights[index]}");
                                                                  _scrollController
                                                                      .animateTo(
                                                                    totalHeights[
                                                                        index],
                                                                    duration: const Duration(
                                                                        milliseconds:
                                                                            500),
                                                                    curve: Curves
                                                                        .easeInOut,
                                                                  );
                                                                },
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: AppColors
                                                                      .fourthColor, // Make the ElevatedButton transparent
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero, // Remove padding inside the ElevatedButton
                                                                ),
                                                                child: const SizedBox
                                                                    .shrink(), // Remove text and shrink the ElevatedButton
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        } else {
                                          // Show a loading indicator while waiting for the future to complete
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 12,
                        left: 12,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Right Area
          Expanded(
            flex: 1,
            child: Container(
              color: AppColors.fifthColor,
              child: const ViewQuizContainer(),
            ),
          ),
        ],
      ),
    );
  }
}
