import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/quizzes/tos.dart';
import 'package:quizmix_frontend/state/models/quizzes/tos_data.dart';
import 'package:quizmix_frontend/state/providers/categories/category_provider.dart';
import 'package:quizmix_frontend/state/providers/quizzes/reviewer_quizzes_provider.dart';
import 'package:quizmix_frontend/state/providers/users/user_details_provider.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';
import 'package:flutter/services.dart';

class TosModalScreen extends ConsumerStatefulWidget {
  const TosModalScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<TosModalScreen> createState() => _TosModalScreenState();
}

class _TosModalScreenState extends ConsumerState<TosModalScreen> {
  List<String> categories = [];
  String selectedCategory = "No Categories Added";
  Map<String, CategoryData> categoryDataMap = {};
  String quizName = '';

  // List<String> allCategories = [
  //   'Basic Theories',
  //   'Algorithms and Programming',
  //   'Computer Components and Hardware',
  //   'System Components',
  //   'Software',
  //   'Development Technology and Management',
  //   'Database',
  //   'Network',
  //   'Security',
  //   'System Audit, Strategy and Planning',
  //   'Business, Corporate & Legal Affairs'
  // ];

  late List<String> allCategories;

  @override
  void initState() {
    super.initState();
    final categoryObjs = ref.read(categoryProvider);
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
            child: Text(category),
          );
        }).toList(),
      ).then((selectedValue) {
        if (selectedValue != null) {
          setState(() {
            allCategories.remove(selectedValue);
            categories.add(selectedValue);
            selectedCategory = selectedValue;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifier = ref.read(reviewerQuizzesProvider.notifier);
    final reviewerId = ref.watch(userProvider).id;

    return Stack(
      children: [
        Container(
          color: const Color(0x800077B6),
        ),
        Scaffold(
          appBar: null,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: IntrinsicHeight(
                child: Container(
                  width: 800,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Add Quiz",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainColor,
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Enter quiz name",
                          ),
                          onChanged: (value) {
                            setState(() {
                              quizName = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        SolidButton(
                          text: "Add Category",
                          onPressed: () {
                            _showCategoryDropdown(context);
                          },
                          icon: const Icon(Icons.add),
                        ),
                        const SizedBox(height: 16),
                        const Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Category",
                                style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.mainColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 25),
                            Expanded(
                              flex: 2,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "No. of questions",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.mainColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(width: 25),
                            Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Difficulty",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.mainColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                            IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Colors.white,
                              ),
                              onPressed: null,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            itemCount:
                                categories.isEmpty ? 1 : categories.length,
                            itemBuilder: (context, index) {
                              if (categories.isEmpty) {
                                return const Expanded(
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
                                );
                              } else {
                                String category = categories[index];
                                return Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        category,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: AppColors.mainColor,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 25),
                                    Expanded(
                                      flex: 2,
                                      child: buildCategoryFormField(
                                        initialValue: categoryDataMap[category]
                                            ?.numberOfQuestions
                                            .toString(),
                                        onChanged: (value) {
                                          updateCategoryData(
                                            category: category,
                                            number: int.parse(value),
                                            isDifficulty: false,
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 25),
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
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              flex: 1,
                              child: SolidButton(
                                text: "Cancel",
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                            const SizedBox(width: 25),
                            Expanded(
                              flex: 1,
                              child: SolidButton(
                                text: "Save",
                                onPressed: () {
                                  final TOS tos = TOS(
                                    madeBy: reviewerId,
                                    title: quizName,
                                    categories: categories,
                                    quantities: categories
                                        .map((category) =>
                                            categoryDataMap[category]
                                                ?.numberOfQuestions ??
                                            0)
                                        .toList(),
                                    difficulties: categories
                                        .map((category) =>
                                            categoryDataMap[category]
                                                ?.difficulty ??
                                            0)
                                        .toList(),
                                  );

                                  // let our notifier know that a change in the api has occured
                                  notifier.addQuiz(tos).then(
                                      (value) => {Navigator.pop(context)});
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
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
}
