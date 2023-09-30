import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/quizzes/tos.dart';
import 'package:quizmix_frontend/state/models/quizzes/tos_data.dart';
import 'package:quizmix_frontend/state/providers/categories/category_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/reviewer_quizzes_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/process_state_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';
import 'package:quizmix_frontend/views/widgets/responsive_solid_button.dart';
import 'package:quizmix_frontend/views/widgets/text_field.dart';

class CreateQuizModal extends ConsumerStatefulWidget {
  const CreateQuizModal({Key? key}) : super(key: key);

  @override
  CreateQuizModalState createState() => CreateQuizModalState();
}

class CreateQuizModalState extends ConsumerState<CreateQuizModal> {
  final TextEditingController quizNameController = TextEditingController();
  List<String> categories = [];
  String selectedCategory = "No Categories Added";
  Map<String, CategoryData> categoryDataMap = {};

  late List<String> allCategories;

  @override
  void initState() {
    super.initState();
    final categoryObjs = ref.read(categoryProvider.notifier).categories();
    allCategories = categoryObjs.map((category) => category.name).toList();
  }

  void _showCategoryDropdown(BuildContext context) {
    if (allCategories.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No more available categories")),
      );
    } else {
      RenderBox button = context.findRenderObject() as RenderBox;
      Offset offset = button.localToGlobal(Offset.zero);

      showMenu(
        context: context,
        position: RelativeRect.fromLTRB(
          offset.dx,
          offset.dy + button.size.height,
          0,
          0,
        ),
        items: allCategories.map((category) {
          return PopupMenuItem<String>(
            value: category,
            child: Text(
              category,
              style: const TextStyle(
                color: AppColors.white,
              ),
            ),
          );
        }).toList(),
      ).then((selectedValue) {
        if (selectedValue != null) {
          setState(() {
            updateCategoryData(
              category: selectedValue,
              number: 1,
              isDifficulty: false,
            );
            updateCategoryData(
              category: selectedValue,
              number: 0,
              isDifficulty: true,
            );
            allCategories.remove(selectedValue);
            categories.add(selectedValue);
            selectedCategory = selectedValue;
          });
        }
      });
    }
  }

  TextFormField buildCategoryFormField(
      {required String? initialValue, required Function(String) onChanged}) {
    return TextFormField(
      initialValue: initialValue,
      decoration: const InputDecoration(
        hintText: "",
      ),
      textAlign: TextAlign.center,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*$')),
      ],
      onChanged: onChanged,
    );
  }

  void updateCategoryData({
    required String category,
    required int number,
    required bool isDifficulty,
  }) {
    categoryDataMap[category] ??= CategoryData();

    if (isDifficulty) {
      categoryDataMap[category]?.difficulty = number;
    } else {
      categoryDataMap[category]?.numberOfQuestions = number;
    }
  }

  @override
  Widget build(BuildContext context) {
    final reviewerId = ref.watch(userProvider).id;
    final processState = ref.watch(processStateProvider);
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: null,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: 800,
            padding: const EdgeInsets.fromLTRB(24, 0, 4, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: processState == ProcessState.loading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(24, 48, 24, 48),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 48.0,
                              width: 48.0,
                              child:
                                  CircularProgressIndicator(strokeWidth: 6.0),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              "Creating Quiz...",
                              style: TextStyle(
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 24),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        ref
                                            .read(modalStateProvider.notifier)
                                            .updateModalState(ModalState.none);
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
                                          Text('Back to Quizzes'),
                                        ],
                                      ),
                                    ),
                                    const Text(
                                      "Create Quiz",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ResponsiveSolidButton(
                                text: "Add Category",
                                icon: const Icon(Icons.add),
                                condition: screenWidth > 580,
                                onPressed: () {
                                  _showCategoryDropdown(context);
                                },
                              ),
                              const SizedBox(width: 12),
                              ResponsiveSolidButton(
                                text: 'Create Quiz',
                                icon: const Icon(Icons.play_circle_outline),
                                condition: true,
                                onPressed: () {
                                  if (categories.isNotEmpty &&
                                      quizNameController.text.isNotEmpty) {
                                    ref
                                        .read(processStateProvider.notifier)
                                        .updateProcessState(
                                            ProcessState.loading);
                                    final TOS tos = TOS(
                                      madeBy: reviewerId,
                                      title: quizNameController.text,
                                      categories: categories,
                                      quantities: categories
                                          .map((category) =>
                                              categoryDataMap[category]
                                                  ?.numberOfQuestions ??
                                              1)
                                          .toList(),
                                      difficulties: categories
                                          .map((category) =>
                                              categoryDataMap[category]
                                                  ?.difficulty ??
                                              0)
                                          .toList(),
                                    );

                                    // let our notifier know that a change in the api has occured
                                    ref
                                        .read(reviewerQuizzesProvider.notifier)
                                        .addQuiz(tos)
                                        .then(
                                      (value) {
                                        ref
                                            .read(modalStateProvider.notifier)
                                            .updateModalState(ModalState.none);
                                        ref
                                            .read(processStateProvider.notifier)
                                            .updateProcessState(
                                                ProcessState.done);
                                      },
                                      onError: (err) {
                                        ref
                                            .read(processStateProvider.notifier)
                                            .updateProcessState(
                                                ProcessState.done);
                                      },
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                          const Text(
                            "Note: The Difficulty ranges are -50 to -30 (Very Easy), -30 to -10 (Easy), -10 to 10 (Average), 10 to 30 (Hard), 30 to 50 (Very Hard)",
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 24),
                          TextFieldWidget(
                            labelText: "Quiz Name",
                            controller: quizNameController,
                          ),
                          const SizedBox(height: 8),
                          categories.isNotEmpty
                              ? const Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        "Category",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 24),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Quantity",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 24),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        "Difficulty",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.clear,
                                        color: Colors.white,
                                      ),
                                      onPressed: null,
                                      color: Colors.white,
                                    ),
                                  ],
                                )
                              : const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 24),
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.category,
                                          size: 64,
                                          color: Colors.grey,
                                        ),
                                        SizedBox(height: 16),
                                        Text(
                                          "No Categories Added",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: categories.length,
                            itemBuilder: (context, index) {
                              String category = categories[index];
                              return Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Text(
                                      category,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  Expanded(
                                    flex: 2,
                                    child: buildCategoryFormField(
                                      initialValue: categoryDataMap[category]
                                              ?.numberOfQuestions
                                              .toString() ??
                                          '1',
                                      onChanged: (value) {
                                        updateCategoryData(
                                          category: category,
                                          number: int.parse(value),
                                          isDifficulty: false,
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 24),
                                  Expanded(
                                    flex: 2,
                                    child: buildCategoryFormField(
                                      initialValue: categoryDataMap[category]
                                              ?.difficulty
                                              .toString() ??
                                          '0',
                                      onChanged: (value) {
                                        updateCategoryData(
                                          category: category,
                                          number: int.parse(value),
                                          isDifficulty: true,
                                        );
                                      },
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: () {
                                      setState(() {
                                        String removedCategory =
                                            categories.removeAt(index);
                                        allCategories.add(removedCategory);
                                        allCategories.sort();
                                      });
                                    },
                                  ),
                                ],
                              );
                            },
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
