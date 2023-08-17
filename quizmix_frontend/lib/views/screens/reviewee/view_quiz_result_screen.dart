import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/base_url_provider.dart';
import 'package:quizmix_frontend/state/providers/question_attempts/currently_viewed_question_attempt_provider.dart';
import 'package:quizmix_frontend/state/providers/quiz_attempts/quiz_attempt_questions_responses_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_taken_quiz_provider.dart';
import 'dart:async';

import 'package:quizmix_frontend/views/widgets/reviewee_view_quiz_result/view_question_attempt_container.dart';

class ViewQuizResultScreen extends ConsumerStatefulWidget {
  const ViewQuizResultScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ViewQuizResultScreen> createState() =>
      _ViewQuizResultScreenState();
}

class _ViewQuizResultScreenState extends ConsumerState<ViewQuizResultScreen> {
  final ScrollController _scrollController = ScrollController();

  Future<List<int>> getImageHeights(List<String> imagePaths) async {
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

  @override
  Widget build(BuildContext context) {
    final baseUrl = ref.watch(baseUrlProvider);
    final currentQuiz = ref.watch(currentTakenQuizProvider);
    final attemptDetails = ref.watch(quizAttemptQuestionsResponsesProvider);
    final firstLetter = currentQuiz.title[0];

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
                              child: Center(
                                child: currentQuiz.image != null
                                    ? Image.network(currentQuiz.image!)
                                    : Text(
                                        firstLetter,
                                        style: const TextStyle(
                                          fontSize: 60,
                                          color: AppColors.mainColor,
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              currentQuiz.title,
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Questions',
                                  style: TextStyle(fontSize: 24),
                                ),
                                Text(
                                  'Your Score: ${ref.read(currentTakenQuizProvider.notifier).score}/${ref.read(currentTakenQuizProvider).questions.length}',
                                  style: const TextStyle(fontSize: 24),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            attemptDetails.when(data: (data) {
                              final questions = data.questions;
                              final responses = data.responses;
                              List<String> imageUrls = questions
                                  .map((question) =>
                                      question.image!.contains(baseUrl)
                                          ? question.image!
                                          : baseUrl + question.image!)
                                  .toList();
                              List<double> listViewItemHeights =
                                  List.filled(questions.length, 0.0);
                              return Expanded(
                                child: Row(
                                  children: [
                                    // Left Area
                                    Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        child: ListView.builder(
                                          controller: _scrollController,
                                          itemCount: questions.length,
                                          itemBuilder: (context, index) {
                                            final question = questions[index];
                                            final int questionNumber =
                                                index + 1;
                                            final image = question.image!
                                                    .contains(baseUrl)
                                                ? question.image!
                                                : baseUrl + question.image!;
                                            return Column(
                                              children: [
                                                LayoutBuilder(
                                                  builder:
                                                      (context, constraints) {
                                                    // Store the height of the current item
                                                    listViewItemHeights[index] =
                                                        constraints.maxHeight;
                                                    return InkWell(
                                                        onTap: () {
                                                          ref
                                                              .read(
                                                                  currentViewedQuestionAttemptProvider
                                                                      .notifier)
                                                              .updateCurrentViewedQuestion({
                                                            "qnum":
                                                                questionNumber,
                                                            "question": question
                                                          });
                                                        },
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: AppColors
                                                                  .mainColor,
                                                              width: 1.0,
                                                            ),
                                                            color: Colors.white,
                                                          ),
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Question $questionNumber',
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            16),
                                                              ),
                                                              const SizedBox(
                                                                  height: 8.0),
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: AppColors
                                                                        .thirdColor,
                                                                    width: 1.0,
                                                                  ),
                                                                ),
                                                                child: Image
                                                                    .network(
                                                                  image,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ));
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
                                    Expanded(
                                      child: FutureBuilder<List<int>>(
                                        future: getImageHeights(imageUrls),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            final List<int> imageHeights =
                                                snapshot.data ?? [];
                                            final numberOfItems =
                                                questions.length;

                                            const double defaultFontSize = 16.0;
                                            const double paddingSize = 12.0;
                                            const double spacing = 25.0;
                                            const double verticalBorders = 4;

                                            List<double> totalHeights =
                                                List.filled(numberOfItems, 0.0);
                                            double itemHeight =
                                                defaultFontSize +
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
                                                    const EdgeInsets.fromLTRB(
                                                        12, 12, 12, 3),
                                                child: LayoutBuilder(
                                                  builder:
                                                      (context, constraints) {
                                                    // Calculate the width and height based on percentage of the available space
                                                    double gridWidth =
                                                        constraints.maxWidth *
                                                            0.1;

                                                    return GridView.builder(
                                                      gridDelegate:
                                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                                        maxCrossAxisExtent: 50,
                                                        crossAxisSpacing:
                                                            12.0, // The horizontal spacing between each child in pixel.
                                                        mainAxisSpacing:
                                                            12.0, // The vertical spacing between each child in pixel.
                                                        childAspectRatio:
                                                            1.0, // The ratio of the height to the main-axis extent of each child.
                                                      ),
                                                      itemCount:
                                                          questions.length,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return SizedBox(
                                                          height: gridWidth,
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                width:
                                                                    gridWidth,
                                                                height:
                                                                    gridWidth,
                                                                color: AppColors
                                                                    .fifthColor, // Set the desired color
                                                                child:
                                                                    ElevatedButton(
                                                                  onPressed:
                                                                      () {
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
                                                                    backgroundColor:
                                                                        AppColors
                                                                            .fifthColor,
                                                                    padding:
                                                                        EdgeInsets
                                                                            .zero,
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      '${index + 1}',
                                                                      style: TextStyle(
                                                                          fontSize: MediaQuery.of(context).size.width *
                                                                              0.01,
                                                                          color:
                                                                              AppColors.mainColor),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    );
                                                  },
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
                              );
                            }, error: (err, st) {
                              return const Expanded(
                                child: Center(
                                  child: Text(
                                    'Your attempt could not be retrieved at this time. Please try again later.',
                                  ),
                                ),
                              );
                            }, loading: () {
                              return const Expanded(
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }),
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
                            ref
                                .read(currentViewedQuestionAttemptProvider
                                    .notifier)
                                .updateCurrentViewedQuestion(
                                    {"qnum": 0, "question": Question.base()});
                            Navigator.pop(context);
                            ref
                                .read(currentTakenQuizProvider.notifier)
                                .updateScore(0);
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
              child: const ViewQuestionAttemptContainer(),
            ),
          ),
        ],
      ),
    );
  }
}
