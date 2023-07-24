import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/screens/reviewer/dashboard_screen.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';
import 'package:flutter/services.dart';

class CategoryData {
  int? numberOfQuestions;
  int? difficulty;

  CategoryData({
    this.numberOfQuestions,
    this.difficulty,
  });
}

class TosModalScreen extends StatefulWidget {
  const TosModalScreen({Key? key}) : super(key: key);

  @override
  State<TosModalScreen> createState() => _TosModalScreenState();
}

class _TosModalScreenState extends State<TosModalScreen> {
  List<String> categories = [];
  String selectedCategory = "No Categories Added";
  Map<String, CategoryData> categoryDataMap = {};
  String quizName = '';

  List<String> allCategories = [
    'Basic Theories',
    'Algorithms and Programming',
    'Computer Components and Hardware',
    'System Components',
    'Software',
    'Development Technology and Management',
    'Database',
    'Network',
    'Security',
    'System Audit, Strategy and Planning',
    'Business, Corporate & Legal Affairs'
  ];

  void _showCategoryDropdown(BuildContext context) {
    if (allCategories.isEmpty) {
      // Show a snackbar or any other UI to indicate no more available categories
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No more available categories")),
      );
    } else {
      // Get the position of the "Add Category" button
      RenderBox button = context.findRenderObject() as RenderBox;
      Offset offset = button.localToGlobal(Offset.zero);

      // Show the dropdown menu
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
        // Update the selected category when a value is selected from the dropdown
        if (selectedValue != null) {
          setState(() {
            // Remove the selected category from the dropdown list
            allCategories.remove(selectedValue);

            // Add the selected category to the list
            categories.add(selectedValue);
            selectedCategory = selectedValue;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const DashboardScreen(),
        Container(
          color: const Color(0x800077B6),
        ),
        Scaffold(
          appBar: null,
          backgroundColor: Colors.transparent,
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
                              // Update the quizName whenever the text in the TextFormField changes
                              quizName = value;
                            });
                          },
                        ),
                        const SizedBox(height: 16),
                        SolidButton(
                          text: "Add Category",
                          onPressed: () {
                            // Show the dropdown menu when the "Add Category" button is pressed
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
                                return const Center(
                                  child: Text("No Categories Added"),
                                );
                              } else {
                                String category = categories[index];
                                return Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      // Category
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
                                      child: TextFormField(
                                        initialValue: categoryDataMap[category]
                                            ?.numberOfQuestions
                                            .toString(),
                                        decoration: const InputDecoration(
                                          hintText: "",
                                        ),
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^[0-9]*$')),
                                        ],
                                        onChanged: (value) {
                                          // Update the number of questions for the category
                                          categoryDataMap[category] ??=
                                              CategoryData();
                                          categoryDataMap[category]
                                                  ?.numberOfQuestions =
                                              int.parse(value);
                                          // Print the categoryDataMap for debugging purposes
                                          print("");
                                          print("Quiz Name: $quizName");
                                          print("Category: $category");
                                          print(
                                              "No. of questions: ${categoryDataMap[category]?.numberOfQuestions}");
                                          print(
                                              "Difficulty: ${categoryDataMap[category]?.difficulty}");
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 25),
                                    Expanded(
                                      flex: 2,
                                      child: TextFormField(
                                        initialValue: categoryDataMap[category]
                                            ?.difficulty
                                            .toString(),
                                        decoration: const InputDecoration(
                                          hintText: "",
                                        ),
                                        textAlign: TextAlign.center,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                              RegExp(r'^[0-9]*$')),
                                        ],
                                        onChanged: (value) {
                                          // Update the difficulty for the category
                                          categoryDataMap[category] ??=
                                              CategoryData();
                                          categoryDataMap[category]
                                              ?.difficulty = int.parse(value);
                                          // Print the values for debugging purposes
                                          print("");
                                          print("Quiz Name: $quizName");
                                          print("Category: $category");
                                          print(
                                              "No. of questions: ${categoryDataMap[category]?.numberOfQuestions}");
                                          print(
                                              "Difficulty: ${categoryDataMap[category]?.difficulty}");
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
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
                                  // Add your code for handling "Save" button press here
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
}
