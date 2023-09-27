import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/bytes_to_platform.dart';
import 'package:quizmix_frontend/api/utils/multipart_form_handlers/create_question.utils.dart';
import 'package:quizmix_frontend/api/utils/multipart_form_handlers/update_question.utils.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/categories/category.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/categories/category_provider.dart';
import 'package:quizmix_frontend/state/providers/questions/current_question_provider.dart';
import 'package:quizmix_frontend/state/providers/questions/question_bank_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/process_state_provider.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';
import 'package:quizmix_frontend/views/widgets/text_field.dart';

class CreateEditQuestionModal extends ConsumerStatefulWidget {
  const CreateEditQuestionModal({Key? key}) : super(key: key);

  @override
  CreateEditQuestionModalState createState() => CreateEditQuestionModalState();
}

class CreateEditQuestionModalState
    extends ConsumerState<CreateEditQuestionModal> {
  late String selectedAnswer;
  late Category selectedCategory;
  late TextEditingController questionController;
  late TextEditingController solutionController;
  late TextEditingController choiceAController;
  late TextEditingController choiceBController;
  late TextEditingController choiceCController;
  late TextEditingController choiceDController;
  bool isFirstImageRemoved = false;
  Uint8List? selectedImageBytes;
  bool isDeleting = false;

  @override
  void initState() {
    super.initState();

    final question = ref.read(currentQuestionProvider);
    final categories = ref.read(categoryProvider.notifier).categories();

    if (question == null) {
      selectedAnswer = "a";
      selectedCategory = const Category(id: 0, name: "None");
      questionController = TextEditingController();
      solutionController = TextEditingController();
      choiceAController = TextEditingController();
      choiceBController = TextEditingController();
      choiceCController = TextEditingController();
      choiceDController = TextEditingController();
    } else {
      selectedAnswer = question.answer;
      selectedCategory = categories
          .where((category) => category.id == question.category.id)
          .first;
      questionController = TextEditingController(text: question.question);
      solutionController = TextEditingController(text: question.solution ?? '');
      choiceAController = TextEditingController(text: question.choices[0]);
      choiceBController = TextEditingController(text: question.choices[1]);
      choiceCController = TextEditingController(text: question.choices[2]);
      choiceDController = TextEditingController(text: question.choices[3]);
    }
  }

  @override
  void dispose() {
    questionController.dispose();
    solutionController.dispose();
    choiceAController.dispose();
    choiceBController.dispose();
    choiceCController.dispose();
    choiceDController.dispose();
    super.dispose();
  }

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

  void handleRadioValueChange(String? value) {
    setState(() {
      selectedAnswer = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final client = ref.watch(restClientProvider);
    final token = ref.watch(authTokenProvider).accessToken;
    final question = ref.watch(currentQuestionProvider);
    final categories = ref.watch(categoryProvider.notifier).categories();
    final processState = ref.watch(processStateProvider);

    return Scaffold(
      appBar: null,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            width: 452,
            padding: const EdgeInsets.fromLTRB(24, 0, 4, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: processState == ProcessState.loading
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 48, 24, 48),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 48.0,
                              width: 48.0,
                              child:
                                  CircularProgressIndicator(strokeWidth: 6.0),
                            ),
                            const SizedBox(height: 16.0),
                            Text(
                              question == null
                                  ? "Creating Question"
                                  : isDeleting
                                      ? "Deleting Question"
                                      : "Editing Question",
                              style: const TextStyle(
                                fontSize: 24.0,
                                color: AppColors.mainColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          TextButton(
                            onPressed: () {
                              question == null
                                  ? ref
                                      .read(modalStateProvider.notifier)
                                      .updateModalState(ModalState.none)
                                  : ref
                                      .read(modalStateProvider.notifier)
                                      .updateModalState(
                                          ModalState.viewQuestion);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              alignment: Alignment.centerLeft,
                              foregroundColor: AppColors.mainColor,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.arrow_back,
                                  size: 16.0,
                                  color: AppColors.mainColor,
                                ),
                                Text(question == null
                                    ? "Back to Question Bank"
                                    : "Back to Question"),
                              ],
                            ),
                          ),
                          Text(
                            question == null
                                ? "Create Question"
                                : "Edit Question",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFieldWidget(
                            labelText: 'Question',
                            controller: questionController,
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<Category>(
                            value: selectedCategory,
                            onChanged: (Category? newValue) {
                              setState(() {
                                selectedCategory = newValue!;
                              });
                            },
                            items: [
                              const Category(id: 0, name: "None"),
                              ...categories
                            ].map((Category item) {
                              return DropdownMenuItem<Category>(
                                value: item,
                                child: Text(item.name),
                              );
                            }).toList(),
                            decoration: const InputDecoration(
                              labelText: 'Category - system selects if "None"',
                              border: OutlineInputBorder(),
                            ),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 12),
                          Stack(
                            children: [
                              InkWell(
                                onTap: _selectImage,
                                child: selectedImageBytes != null
                                    ? Image.memory(
                                        selectedImageBytes!,
                                        fit: BoxFit.cover,
                                      )
                                    : !isFirstImageRemoved &&
                                            question != null &&
                                            question.image != null
                                        ? Image.network(
                                            question.image!,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                            width: double.infinity,
                                            height: 120,
                                            color: Colors.grey[300],
                                            child: const Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.upload_rounded,
                                                  size: 48,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(height: 8),
                                                Text(
                                                  'Upload Question Image',
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                              ),
                              if (selectedImageBytes != null ||
                                  (!isFirstImageRemoved &&
                                      question != null &&
                                      question.image != null))
                                Positioned(
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
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Radio(
                                value: "a",
                                groupValue: selectedAnswer,
                                onChanged: handleRadioValueChange,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFieldWidget(
                                  labelText: 'Choice A',
                                  controller: choiceAController,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Radio(
                                value: "b",
                                groupValue: selectedAnswer,
                                onChanged: handleRadioValueChange,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFieldWidget(
                                  labelText: 'Choice B',
                                  controller: choiceBController,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Radio(
                                value: "c",
                                groupValue: selectedAnswer,
                                onChanged: handleRadioValueChange,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFieldWidget(
                                  labelText: 'Choice C',
                                  controller: choiceCController,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Radio(
                                value: "d",
                                groupValue: selectedAnswer,
                                onChanged: handleRadioValueChange,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: TextFieldWidget(
                                  labelText: 'Choice D',
                                  controller: choiceDController,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          TextFieldWidget(
                            labelText: 'Explanation',
                            controller: solutionController,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: question == null
                                    ? const SizedBox()
                                    : SolidButton(
                                        text: "Delete Question",
                                        icon: const Icon(Icons.delete),
                                        backgroundColor: AppColors.red,
                                        onPressed: () async {
                                          setState(() {
                                            isDeleting = true;
                                          });
                                          ref
                                              .read(
                                                  processStateProvider.notifier)
                                              .updateProcessState(
                                                  ProcessState.loading);
                                          try {
                                            await client.deleteQuestionById(
                                                token, question.id);

                                            await ref
                                                .read(questionBankProvider
                                                    .notifier)
                                                .fetchQuestions();
                                            ref
                                                .read(processStateProvider
                                                    .notifier)
                                                .updateProcessState(
                                                    ProcessState.done);
                                            ref
                                                .read(
                                                    modalStateProvider.notifier)
                                                .updateModalState(
                                                    ModalState.none);
                                          } catch (err) {
                                            ref
                                                .read(processStateProvider
                                                    .notifier)
                                                .updateProcessState(
                                                    ProcessState.done);
                                          }
                                        }),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: SolidButton(
                                  text: question == null
                                      ? "Create Question"
                                      : "Edit Question",
                                  icon: const Icon(Icons.play_circle_outline),
                                  onPressed: () async {
                                    if (questionController.text.isNotEmpty) {
                                      ref
                                          .read(processStateProvider.notifier)
                                          .updateProcessState(
                                              ProcessState.loading);

                                      PlatformFile? imageFile;
                                      if (selectedImageBytes != null) {
                                        imageFile = bytesToPlatform(
                                            selectedImageBytes!);
                                      }

                                      if (question == null) {
                                        final dataToSend = {
                                          "question": questionController.text,
                                          "choiceA": choiceAController.text,
                                          "choiceB": choiceBController.text,
                                          "choiceC": choiceCController.text,
                                          "choiceD": choiceDController.text,
                                          "answer": selectedAnswer,
                                          "category": selectedCategory.id,
                                          "solution": solutionController.text,
                                        };
                                        createQuestion(
                                                dataToSend, imageFile, ref)
                                            .then((value) {
                                          ref
                                              .read(
                                                  processStateProvider.notifier)
                                              .updateProcessState(
                                                  ProcessState.done);
                                          ref
                                              .read(modalStateProvider.notifier)
                                              .updateModalState(
                                                  ModalState.none);
                                        }, onError: (err) {
                                          ref
                                              .read(
                                                  processStateProvider.notifier)
                                              .updateProcessState(
                                                  ProcessState.done);
                                        });
                                      } else {
                                        final newChoices = [
                                          choiceAController.text,
                                          choiceBController.text,
                                          choiceCController.text,
                                          choiceDController.text,
                                        ];
                                        final newQuestion = Question(
                                          id: question.id,
                                          question: questionController.text,
                                          image: question.image,
                                          answer: selectedAnswer,
                                          choices: newChoices,
                                          category: selectedCategory,
                                          solution: solutionController.text,
                                          // Add reset functionality later!
                                          parameters: question.parameters,
                                          responses: question.responses,
                                          thetas: question.thetas,
                                        );

                                        updateQuestion(newQuestion, imageFile,
                                                isFirstImageRemoved, ref)
                                            .then((value) {
                                          ref
                                              .read(
                                                  processStateProvider.notifier)
                                              .updateProcessState(
                                                  ProcessState.done);
                                          ref
                                              .read(modalStateProvider.notifier)
                                              .updateModalState(
                                                  ModalState.none);
                                        }, onError: (err) {
                                          ref
                                              .read(
                                                  processStateProvider.notifier)
                                              .updateProcessState(
                                                  ProcessState.done);
                                        });
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
