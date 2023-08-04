import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';
import 'package:flutter/services.dart';

final List<String> allCategories = [
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

final List<String> allDiscrimination = [
  'High Negative',
  'Negative',
  'Low',
  'Positive',
  'High Positive'
];

final List<String> allDifficulty = [
  'Very Easy',
  'Easy',
  'Average',
  'Hard',
  'Very Hard'
];

class QuestionSearchModalScreen extends ConsumerStatefulWidget {
  const QuestionSearchModalScreen({
    Key? key,
    required this.onCancel,
  }) : super(key: key);

  final void Function() onCancel;

  @override
  ConsumerState<QuestionSearchModalScreen> createState() =>
      _QuestionSearchModalScreenState();
}

class _QuestionSearchModalScreenState
    extends ConsumerState<QuestionSearchModalScreen> {
  String searchTerm = '';
  late List<bool> isCheckedCategories;
  late List<bool> isCheckedDiscrimination;
  late List<bool> isCheckedDifficulty;

  @override
  void initState() {
    super.initState();
    // Initialize isCheckedList here, after the widget is fully constructed
    isCheckedCategories = List.generate(allCategories.length, (index) => true);
    isCheckedDiscrimination =
        List.generate(allDiscrimination.length, (index) => true);
    isCheckedDifficulty = List.generate(allDifficulty.length, (index) => true);
  }

  @override
  Widget build(BuildContext context) {
    // final notifier = ref.read(reviewerQuizzesProvider.notifier);
    // final reviewerId = ref.watch(reviewerProvider).id;

    return Scaffold(
      appBar: null,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: IntrinsicHeight(
            child: Container(
              width: 800,
              padding: const EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Advanced Search",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainColor,
                      ),
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Write any question or choice text here",
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchTerm = value;
                        });
                      },
                    ),
                    const SizedBox(height: 25),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "Category",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.mainColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              ...List.generate(allCategories.length, (index) {
                                return Row(
                                  children: [
                                    Checkbox(
                                      value: isCheckedCategories[index],
                                      onChanged: (value) {
                                        setState(() {
                                          isCheckedCategories[index] =
                                              !isCheckedCategories[index];
                                        });
                                      },
                                      activeColor: AppColors.mainColor,
                                    ),
                                    Expanded(
                                      child: Text(
                                        allCategories[index],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: AppColors.mainColor,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "Discrimination Index",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.mainColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              ...List.generate(allDiscrimination.length,
                                  (index) {
                                return Row(
                                  children: [
                                    Checkbox(
                                      value: isCheckedDiscrimination[index],
                                      onChanged: (value) {
                                        setState(() {
                                          isCheckedDiscrimination[index] =
                                              !isCheckedDiscrimination[index];
                                        });
                                      },
                                      activeColor: AppColors.mainColor,
                                    ),
                                    Expanded(
                                      child: Text(
                                        allDiscrimination[index],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: AppColors.mainColor,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                              const SizedBox(height: 12),
                              const Align(
                                alignment: Alignment.topCenter,
                                child: Text(
                                  "Difficulty Index",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: AppColors.mainColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              ...List.generate(allDifficulty.length, (index) {
                                return Row(
                                  children: [
                                    Checkbox(
                                      value: isCheckedDifficulty[index],
                                      onChanged: (value) {
                                        setState(() {
                                          isCheckedDifficulty[index] =
                                              !isCheckedDifficulty[index];
                                        });
                                      },
                                      activeColor: AppColors.mainColor,
                                    ),
                                    Expanded(
                                      child: Text(
                                        allDifficulty[index],
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: AppColors.mainColor,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(width: 25),
                        // Expanded(
                        //   flex: 2,
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.start,
                        //     children: [],
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 1,
                          child: SolidButton(
                            text: "Cancel",
                            onPressed: widget.onCancel,
                          ),
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          flex: 1,
                          child: SolidButton(
                            text: "Save",
                            onPressed: () {
                              // final TOS tos = TOS(
                              //   madeBy: reviewerId,
                              //   title: searchTerm,
                              //   categories: categories,
                              //   quantities: categories
                              //       .map((category) =>
                              //           categoryDataMap[category]
                              //               ?.numberOfQuestions ??
                              //           0)
                              //       .toList(),
                              //   difficulties: categories
                              //       .map((category) =>
                              //           categoryDataMap[category]?.difficulty ??
                              //           0)
                              //       .toList(),
                              // );

                              // // let our notifier know that a change in the api has occured
                              // notifier
                              //     .addQuiz(tos)
                              //     .then((value) => {Navigator.pop(context)});
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
    );
  }
}
