import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/bytes_to_platform.dart';
import 'package:quizmix_frontend/api/utils/multipart_form_handlers/create_mix.utils.dart';
import 'package:quizmix_frontend/api/utils/multipart_form_handlers/update_mix.utils.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/mixes/mix.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/mixes/available_mix_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/responsive_solid_button.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_create_edit_mix/create_edit_mix_question_card.dart';
import 'package:file_picker/file_picker.dart';

class CreateEditMixScreen extends ConsumerStatefulWidget {
  const CreateEditMixScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<CreateEditMixScreen> createState() =>
      _CreateEditMixScreenState();
}

class _CreateEditMixScreenState extends ConsumerState<CreateEditMixScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _textFieldKey =
      GlobalKey<FormFieldState<String>>();
  bool isFirstImageRemoved = false;
  Uint8List? selectedImageBytes;

  void _selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        isFirstImageRemoved = false;
        selectedImageBytes = file.bytes;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final mix = ref.watch(currentMixProvider);
    final availableQuestions = ref.watch(availableMixQuestionsProvider);
    final currentQuestions = ref.watch(currentMixQuestionsProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Scaffold(
          body: Column(
            children: [
              Expanded(
                flex: screenHeight > 360 ? 0 : 1,
                child: SingleChildScrollView(
                  child: Container(
                    color: AppColors.white,
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                                alignment: Alignment.centerLeft,
                                foregroundColor: AppColors.mainColor,
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.arrow_back,
                                    size: 16.0,
                                    color: AppColors.mainColor,
                                  ),
                                  Text('Back to Home'),
                                ],
                              ),
                            ),
                            Stack(
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
                                        ? Image.memory(
                                            selectedImageBytes!,
                                            fit: BoxFit.cover,
                                          )
                                        : !isFirstImageRemoved &&
                                                mix != null &&
                                                mix.image != null
                                            ? Image.network(
                                                mix.image!,
                                                fit: BoxFit.cover,
                                              )
                                            : Container(
                                                width: double.infinity,
                                                height: 300,
                                                color: Colors.grey[300],
                                                child: const Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.image,
                                                      size: 50,
                                                      color: Colors.grey,
                                                    ),
                                                    SizedBox(height: 10),
                                                    Text(
                                                      'No Image Selected',
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                  ),
                                ),
                                selectedImageBytes != null ||
                                        (!isFirstImageRemoved &&
                                            mix != null &&
                                            mix.image != null)
                                    ? Positioned(
                                        top: 0,
                                        right: 0,
                                        child: RawMaterialButton(
                                          onPressed: () {
                                            setState(() {
                                              isFirstImageRemoved = true;
                                              selectedImageBytes = null;
                                            });
                                          },
                                          fillColor: Colors.red,
                                          shape: const CircleBorder(),
                                          constraints: const BoxConstraints(
                                            minWidth: 36.0,
                                            minHeight: 36.0,
                                          ),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.white,
                                          ),
                                        ))
                                    : const SizedBox(),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(width: 24),
                        SizedBox(
                          height: 168,
                          width: screenWidth - 222,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ResponsiveSolidButton(
                                      text: "Search Question Bank",
                                      condition: screenWidth > 620,
                                      icon: const Icon(Icons.search),
                                      elevation: 8.0,
                                      onPressed: () {},
                                    ),
                                    const SizedBox(width: 12),
                                    ResponsiveSolidButton(
                                      text: mix == null
                                          ? "Create Mix"
                                          : "Apply Edits",
                                      condition: screenWidth > 620,
                                      icon: const Icon(
                                          Icons.check_circle_outlined),
                                      backgroundColor: AppColors.mainColor,
                                      elevation: 8.0,
                                      onPressed: () {
                                        final questions = currentQuestions.when(
                                          data: (data) {
                                            return data;
                                          },
                                          error: (err, st) {
                                            return <Question>[];
                                          },
                                          loading: () {
                                            return <Question>[];
                                          },
                                        );
                                        final questionsIdList = questions
                                            .map((question) => question.id)
                                            .toList();
                                        String? textFieldValue;
                                        if (_formKey.currentState != null) {
                                          textFieldValue =
                                              _textFieldKey.currentState!.value;
                                        }
                                        if (questions.isEmpty ||
                                            textFieldValue == null ||
                                            textFieldValue.isEmpty) {
                                          return;
                                        }
                                        PlatformFile? imageFile;
                                        if (selectedImageBytes != null) {
                                          imageFile = bytesToPlatform(
                                              selectedImageBytes!);
                                        }
                                        if (mix == null) {
                                          final revieweeId =
                                              ref.read(userProvider).id;
                                          final newMix = {
                                            "title": textFieldValue,
                                            "made_by": revieweeId,
                                            "questions": questionsIdList,
                                          };
                                          createMix(newMix, imageFile, ref)
                                              .then((value) {
                                            Navigator.pop(context);
                                          });
                                        } else {
                                          final newMix = Mix(
                                            id: mix.id,
                                            title: textFieldValue,
                                            image: mix.image,
                                            madeBy: mix.madeBy,
                                            createdOn: mix.createdOn,
                                            questions: questions,
                                          );
                                          updateMix(newMix, imageFile,
                                                  isFirstImageRemoved, ref)
                                              .then((value) {
                                            Navigator.pop(context);
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Form(
                                  key: _formKey,
                                  child: Container(
                                    constraints:
                                        const BoxConstraints(maxWidth: 620),
                                    child: TextFormField(
                                      key: _textFieldKey,
                                      initialValue: mix?.title,
                                      decoration: const InputDecoration(
                                        labelText: "Mix Title",
                                      ),
                                      style: const TextStyle(
                                        fontSize: 40,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: AppColors.iconColor,
                        child: availableQuestions.when(
                          data: (questions) {
                            if (questions.isNotEmpty) {
                              return ListView.builder(
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
                            return const Expanded(
                              child: EmptyDataPlaceholder(
                                  message: "There are no questions to show."),
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
                    ),
                    Expanded(
                      child: Container(
                        color: AppColors.mainColor,
                        child: currentQuestions.when(
                          data: (questions) {
                            if (questions.isNotEmpty) {
                              return ListView.builder(
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
