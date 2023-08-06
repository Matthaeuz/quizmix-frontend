/// The `MyMixesScreen` class is a Flutter widget that displays a screen for viewing a question
/// bank and allows users to search for questions and view individual questions.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/questions/question_bank_provider.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_create_edit_mix/create_edit_mix_question_card.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class CreateEditMixScreen extends ConsumerStatefulWidget {
  const CreateEditMixScreen({
    Key? key,
    required this.action,
  }) : super(key: key);

  final String action;

  @override
  ConsumerState<CreateEditMixScreen> createState() =>
      _CreateEditMixScreenState();
}

class _CreateEditMixScreenState extends ConsumerState<CreateEditMixScreen> {
  bool isOpenModal = false;
  AsyncValue<List<Question>> availableQuestions = const AsyncValue.loading();
  AsyncValue<List<Question>> currentQuestions = const AsyncValue.loading();

  @override
  void initState() {
    super.initState();
    // temporary
    final questionsNotInMix = widget.action == "create"
        ? ref.read(questionBankProvider).when(
            data: (data) {
              return data;
            },
            error: (err, st) {},
            loading: () {})
        : ref.read(questionBankProvider).when(
            data: (data) {
              return data;
            },
            error: (err, st) {},
            loading: () {});
    // temporary
    final questionsInMix =
        widget.action == "create" ? <Question>[] : <Question>[];
    availableQuestions = AsyncValue.data(questionsNotInMix!);
    currentQuestions = AsyncValue.data(questionsInMix);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Row(
            children: [
              // Left Side
              Expanded(
                child: Container(
                  color: Colors.white,
                  padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                const SizedBox(width: 25),
                                const Expanded(
                                  child: Text(
                                    'Mix Builder',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: SolidButton(
                                text: 'Search',
                                onPressed: () {
                                  setState(() {
                                    isOpenModal = true;
                                  });
                                },
                                icon: const Icon(Icons.search),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: availableQuestions.when(
                          data: (questions) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: questions.length,
                              itemBuilder: (context, index) {
                                return CreateEditMixQuestionCard(
                                  questionDetails: questions[index],
                                  action: "Add",
                                  onClick: () {
                                    final newAvailableQuestions =
                                        List<Question>.from(questions);
                                    List<Question> newCurrentQuestions = [];
                                    currentQuestions.when(
                                      data: (questions) {
                                        newCurrentQuestions =
                                            List<Question>.from(questions);
                                      },
                                      loading: () {},
                                      error: (err, stack) {},
                                    );
                                    newCurrentQuestions.add(
                                        newAvailableQuestions.removeAt(index));
                                    setState(() {
                                      availableQuestions = AsyncValue.data(
                                          newAvailableQuestions);
                                      currentQuestions =
                                          AsyncValue.data(newCurrentQuestions);
                                    });
                                  },
                                );
                              },
                            );
                          },
                          loading: () => const CircularProgressIndicator(),
                          error: (err, stack) => Text('Error: $err'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Right Side
              Expanded(
                child: Container(
                  color: AppColors.fifthColor,
                  padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 35),
                        child: Stack(
                          children: [
                            const Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Your Current Mix',
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                      fontFamily: 'Poppins',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                // for layout purpose only
                                IconButton(
                                  icon: Icon(null),
                                  onPressed: null,
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: SolidButton(
                                text: widget.action == "create"
                                    ? "Create Mix"
                                    : "Apply Edits",
                                onPressed: () {
                                  // add Mix logic
                                },
                                icon: const Icon(Icons.check_circle_outlined),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                // add Image logic
                              },
                              child: Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  color: AppColors.fourthColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Image(
                                  // temp image
                                  image: NetworkImage(
                                    "lib/assets/images/default_pic.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                Container(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: currentQuestions.when(
                          data: (questions) {
                            if (questions.isNotEmpty) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: questions.length,
                                itemBuilder: (context, index) {
                                  return CreateEditMixQuestionCard(
                                    questionDetails: questions[index],
                                    action: "Remove",
                                    onClick: () {
                                      final newCurrentQuestions =
                                          List<Question>.from(questions);
                                      List<Question> newAvailableQuestions = [];
                                      availableQuestions.when(
                                        data: (questions) {
                                          newAvailableQuestions =
                                              List<Question>.from(questions);
                                        },
                                        loading: () {},
                                        error: (err, stack) {},
                                      );
                                      newAvailableQuestions.add(
                                          newCurrentQuestions.removeAt(index));
                                      setState(() {
                                        availableQuestions = AsyncValue.data(
                                            newAvailableQuestions);
                                        currentQuestions = AsyncValue.data(
                                            newCurrentQuestions);
                                      });
                                    },
                                  );
                                },
                              );
                            }
                            return const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Questions you add will appear here',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          },
                          loading: () => const CircularProgressIndicator(),
                          error: (err, stack) => Text('Error: $err'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
