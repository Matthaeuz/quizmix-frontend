import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/bytes_to_platform.dart';
import 'package:quizmix_frontend/api/utils/multipart_form_handlers/update_quiz.utils.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/models/quizzes/quiz.dart';
import 'package:quizmix_frontend/state/providers/quizzes/available_quiz_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_quiz_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/current_viewed_quiz_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/process_state_provider.dart';
// import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';
import 'package:quizmix_frontend/views/modals/mix_advanced_search_modal.dart';
import 'package:quizmix_frontend/views/modals/view_question_modal.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/responsive_solid_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_edit_quiz/edit_quiz_question_card.dart';

class EditQuizScreen extends ConsumerStatefulWidget {
  const EditQuizScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EditQuizScreen> createState() => _CreateEditQuizScreenState();
}

class _CreateEditQuizScreenState extends ConsumerState<EditQuizScreen> {
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
    final quiz = ref.watch(currentQuizViewedProvider);
    final modalState = ref.watch(modalStateProvider);
    final processState = ref.watch(processStateProvider);
    final availableQuestions = ref.watch(availableQuizQuestionsProvider);
    final currentQuestions = ref.watch(currentQuizQuestionsProvider);
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
                                                quiz.image != null
                                            ? Image.network(
                                                quiz.image!,
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
                                            quiz.image != null)
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
                                          fillColor: AppColors.red,
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
                                      isUnpressable:
                                          processState == ProcessState.done
                                              ? false
                                              : true,
                                      elevation: 8.0,
                                      onPressed: () {
                                        ref
                                            .read(modalStateProvider.notifier)
                                            .updateModalState(
                                                ModalState.mixAdvancedSearch);
                                      },
                                    ),
                                    const SizedBox(width: 12),
                                    ResponsiveSolidButton(
                                      text: "Apply Edits",
                                      condition: screenWidth > 620,
                                      icon: const Icon(
                                          Icons.check_circle_outlined),
                                      backgroundColor: AppColors.mainColor,
                                      isUnpressable:
                                          processState == ProcessState.done
                                              ? false
                                              : true,
                                      elevation: 8.0,
                                      onPressed: () async {
                                        ref
                                            .read(processStateProvider.notifier)
                                            .updateProcessState(
                                                ProcessState.loading);
                                        final questions = currentQuestions;
                                        String? textFieldValue;
                                        if (_formKey.currentState != null) {
                                          textFieldValue =
                                              _textFieldKey.currentState!.value;
                                        }
                                        if (questions.isEmpty ||
                                            textFieldValue == null ||
                                            textFieldValue.isEmpty) {
                                          ref
                                              .read(
                                                  processStateProvider.notifier)
                                              .updateProcessState(
                                                  ProcessState.done);
                                          return;
                                        }
                                        PlatformFile? imageFile;
                                        if (selectedImageBytes != null) {
                                          imageFile = bytesToPlatform(
                                              selectedImageBytes!);
                                        }

                                        final newQuiz = Quiz(
                                          id: quiz.id,
                                          title: textFieldValue,
                                          image: quiz.image,
                                          madeBy: quiz.madeBy,
                                          createdOn: quiz.createdOn,
                                          questions: questions,
                                        );

                                        await updateQuiz(newQuiz, imageFile,
                                                isFirstImageRemoved, ref)
                                            .then((value) {
                                          ref
                                              .read(processStateProvider
                                                  .notifier)
                                              .updateProcessState(
                                                  ProcessState.done);
                                          Navigator.pop(context);
                                        }, onError: (err, st) {
                                          ref
                                              .read(processStateProvider
                                                  .notifier)
                                              .updateProcessState(
                                                  ProcessState.done);
                                        });
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
                                      initialValue: quiz.title,
                                      decoration: const InputDecoration(
                                        labelText: "Quiz Title",
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
              processState == ProcessState.done
                  ? Expanded(
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
                                        return Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: index == 0 ? 12 : 0,
                                              bottom:
                                                  index == questions.length - 1
                                                      ? 12
                                                      : 0,
                                            ),
                                            child: EditQuizQuestionCard(
                                              questionDetails: questions[index],
                                              action: EditQuizAction.add,
                                              condition: screenWidth > 620,
                                              onClick: () async {
                                                Question? newQuestion = await ref
                                                    .read(
                                                        availableQuizQuestionsProvider
                                                            .notifier)
                                                    .removeQuestion(index);
                                                ref
                                                    .read(
                                                        currentQuizQuestionsProvider
                                                            .notifier)
                                                    .addQuestion(newQuestion!);
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }
                                  return const Center(
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: EdgeInsets.all(12),
                                        child: EmptyDataPlaceholder(
                                            message:
                                                "There are no available questions"),
                                      ),
                                    ),
                                  );
                                },
                                loading: () => const Center(
                                  child: SizedBox(
                                    width: 60.0,
                                    height: 60.0,
                                    child: CircularProgressIndicator(
                                      color: AppColors.white,
                                    ),
                                  ),
                                ),
                                error: (err, stack) => Text('Error: $err'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: AppColors.mainColor,
                              child: currentQuestions.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: currentQuestions.length,
                                      itemBuilder: (context, index) {
                                        return Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              top: index == 0 ? 12 : 0,
                                              bottom: index ==
                                                      currentQuestions.length -
                                                          1
                                                  ? 12
                                                  : 0,
                                            ),
                                            //create new card
                                            child: EditQuizQuestionCard(
                                              questionDetails:
                                                  currentQuestions[index],
                                              action:
                                                  EditQuizAction.remove,
                                              condition: screenWidth > 620,
                                              onClick: () {
                                                Question? newQuestion = ref
                                                    .read(
                                                        currentQuizQuestionsProvider
                                                            .notifier)
                                                    .removeQuestion(index);
                                                ref
                                                    .read(
                                                        availableQuizQuestionsProvider
                                                            .notifier)
                                                    .addQuestion(newQuestion);
                                              },
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : const Center(
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: EdgeInsets.all(12),
                                          child: EmptyDataPlaceholder(
                                            message:
                                                "There are no questions in your Quiz",
                                          ),
                                        ),
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Expanded(
                      child: Container(
                        color: AppColors.mainColor,
                        child: const Center(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 48.0,
                                  width: 48.0,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 6.0,
                                    color: AppColors.white,
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  "Applying edits...",
                                  style: TextStyle(
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        if (modalState == ModalState.mixAdvancedSearch) ...[
          // make this
          Container(
            color: AppColors.fourthColor.withOpacity(0.8),
            child: const MixAdvancedSearhModal(),
          ),
        ] else if (modalState == ModalState.viewQuestion) ...[
          Container(
            color: AppColors.fourthColor.withOpacity(0.8),
            child: const ViewQuestionModal(),
          ),
        ]
      ],
    );
  }
}
