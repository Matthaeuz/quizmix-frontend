import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/mixes/available_mix_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/mix_question_search_filter_provider.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

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

class MixQuestionSearchModalScreen extends ConsumerStatefulWidget {
  const MixQuestionSearchModalScreen({
    Key? key,
    required this.onClick,
  }) : super(key: key);

  final void Function() onClick;

  @override
  ConsumerState<MixQuestionSearchModalScreen> createState() =>
      _MixQuestionSearchModalScreenState();
}

class _MixQuestionSearchModalScreenState
    extends ConsumerState<MixQuestionSearchModalScreen> {
  late String searchTerm;
  late List<bool> isCheckedCategories;
  late List<bool> isCheckedDiscrimination;
  late List<bool> isCheckedDifficulty;

  @override
  void initState() {
    super.initState();
    final filters = ref.read(mixQuestionSearchFilterProvider);
    searchTerm = filters["text"];
    isCheckedCategories = List.from(filters["categories"]);
    isCheckedDiscrimination = List.from(filters["discrimination"]);
    isCheckedDifficulty = List.from(filters["difficulty"]);
  }

  @override
  Widget build(BuildContext context) {
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
                      initialValue: searchTerm,
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
                            onPressed: widget.onClick,
                          ),
                        ),
                        const SizedBox(width: 25),
                        Expanded(
                          flex: 1,
                          child: SolidButton(
                            text: "Search",
                            onPressed: () {
                              final filters = {
                                "text": searchTerm,
                                "categories": isCheckedCategories,
                                "discrimination": isCheckedDiscrimination,
                                "difficulty": isCheckedDifficulty
                              };
                              ref
                                  .read(availableMixQuestionsProvider.notifier)
                                  .searchQuestions(filters);
                              ref
                                  .read(
                                      mixQuestionSearchFilterProvider.notifier)
                                  .updateFilters(filters);
                              widget.onClick();
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
