/// The `MyMixesScreen` class is a Flutter widget that displays a screen for viewing a question
/// bank and allows users to search for questions and view individual questions.
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/bytes_to_platform.dart';
import 'package:quizmix_frontend/api/utils/multipart_form_handlers/create_mix.utils.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/mixes/available_mix_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/reviewees/reviewee_details_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewee/mix_question_search_modal_screen.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_create_edit_mix/create_edit_mix_question_card.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';
import 'package:file_picker/file_picker.dart';

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
  TextEditingController mixTitle = TextEditingController();
  Uint8List? selectedImageBytes;

  void _selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        selectedImageBytes = file.bytes; // Store the bytes for later use
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableQuestions = ref.watch(availableMixQuestionsProvider);
    final currentQuestions = ref.watch(currentMixQuestionsProvider);

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
                            if (questions.isNotEmpty) {
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: questions.length,
                                itemBuilder: (context, index) {
                                  return CreateEditMixQuestionCard(
                                    questionDetails: questions[index],
                                    action: "Add",
                                    onClick: () async {
                                      Question? newQuestion = await ref
                                          .read(availableMixQuestionsProvider
                                              .notifier)
                                          .removeQuestion(index);
                                      ref
                                          .read(currentMixQuestionsProvider
                                              .notifier)
                                          .addQuestion(newQuestion!);
                                    },
                                  );
                                },
                              );
                            }
                            return const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'There are no questions to show',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontFamily: 'Poppins',
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            );
                          },
                          loading: () => const Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(),
                            ),
                          ),
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
                                  final questions = currentQuestions.when(
                                    data: (data) {
                                      return data
                                          .map((question) => question.id)
                                          .toList();
                                    },
                                    error: (err, st) {
                                      return <int>[];
                                    },
                                    loading: () {
                                      return <int>[];
                                    },
                                  );
                                  if (questions.isEmpty ||
                                      mixTitle.text.isEmpty) {
                                    return;
                                  }
                                  if (widget.action == "create") {
                                    PlatformFile? imageFile;

                                    final reviewee =
                                        ref.read(revieweeProvider).when(
                                              data: (data) {
                                                return data.id;
                                              },
                                              error: (err, st) {},
                                              loading: () {},
                                            );

                                    final newMix = {
                                      "title": mixTitle.text,
                                      "made_by": reviewee!,
                                      "questions": questions,
                                    };
                                    if (selectedImageBytes != null) {
                                      imageFile =
                                          bytesToPlatform(selectedImageBytes!);
                                    }
                                    createMix(newMix, imageFile, ref)
                                        .then((value) {
                                      Navigator.pop(context);
                                    });
                                  }
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
                              onTap: _selectImage,
                              child: Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  color: AppColors.fourthColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: selectedImageBytes != null
                                    ? Image.memory(selectedImageBytes!,
                                        fit: BoxFit.cover)
                                    : Container(
                                        width: double.infinity,
                                        height: 300,
                                        color: Colors.grey[300],
                                        // child: question.image == null
                                        //     ? const Column(
                                        //         mainAxisAlignment:
                                        //             MainAxisAlignment.center,
                                        //         children: [
                                        //           Icon(Icons.image,
                                        //               size: 50,
                                        //               color: Colors
                                        //                   .grey), // Placeholder icon
                                        //           SizedBox(height: 10),
                                        //           Text('No Image Selected',
                                        //               style: TextStyle(
                                        //                   color: Colors.grey)),
                                        //         ],
                                        //       )
                                        //     : Image.network(question.image!),
                                        child: const Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.image,
                                                size: 50,
                                                color: Colors
                                                    .grey), // Placeholder icon
                                            SizedBox(height: 10),
                                            Text('No Image Selected',
                                                style: TextStyle(
                                                    color: Colors.grey)),
                                          ],
                                        ),
                                      ),
                              ),
                            ),
                            const SizedBox(width: 25),
                            Expanded(
                              child: TextField(
                                controller: mixTitle,
                                decoration: const InputDecoration(
                                  labelText: "Mix Title",
                                ),
                                style: const TextStyle(
                                  fontSize: 40,
                                ),
                              ),
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
                                    onClick: () async {
                                      Question? newQuestion = await ref
                                          .read(currentMixQuestionsProvider
                                              .notifier)
                                          .removeQuestion(index);
                                      ref
                                          .read(availableMixQuestionsProvider
                                              .notifier)
                                          .addQuestion(newQuestion!);
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
                          loading: () => const Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(),
                            ),
                          ),
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
        isOpenModal == true
            ? Container(color: const Color(0x800077B6))
            : const SizedBox(),
        isOpenModal == true
            ? MixQuestionSearchModalScreen(onClick: () {
                setState(() {
                  isOpenModal = false;
                });
              })
            : const SizedBox(),
      ],
    );
  }
}
