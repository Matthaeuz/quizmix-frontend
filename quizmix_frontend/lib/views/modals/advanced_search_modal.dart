import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/questions/question_bank_provider.dart';
import 'package:quizmix_frontend/state/providers/questions/question_search_filter_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

// final List<String> allCategories = [
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

class AdvancedSearhModal extends ConsumerStatefulWidget {
  const AdvancedSearhModal({Key? key}) : super(key: key);

  @override
  ConsumerState<AdvancedSearhModal> createState() => _AdvancedSearhModalState();
}

class _AdvancedSearhModalState extends ConsumerState<AdvancedSearhModal> {
  late String searchTerm;
  late List<bool> isCheckedCategories;
  late List<bool> isCheckedDiscrimination;
  late List<bool> isCheckedDifficulty;
  late List<String> categoryNames;

  @override
  void initState() {
    super.initState();
    final filters = ref.read(questionSearchFilterProvider);
    searchTerm = filters["text"];
    isCheckedCategories = List.from(filters["categories"]);
    isCheckedDiscrimination = List.from(filters["discrimination"]);
    isCheckedDifficulty = List.from(filters["difficulty"]);
    categoryNames =
        ref.read(questionSearchFilterProvider.notifier).categoryNames;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: IntrinsicHeight(
            child: Container(
              width: 800,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
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
                    const SizedBox(height: 24),
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
                              ...List.generate(categoryNames.length, (index) {
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
                                        categoryNames[index],
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
                        const SizedBox(width: 24),
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
                        const SizedBox(width: 24),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 1,
                          child: SolidButton(
                            text: "Cancel",
                            onPressed: () {
                              ref
                                  .read(modalStateProvider.notifier)
                                  .updateModalState(ModalState.none);
                            },
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          flex: 1,
                          child: SolidButton(
                            text: "Search",
                            onPressed: () {
                              final filters = {
                                "text": searchTerm,
                                "categories": isCheckedCategories,
                                "discrimination": isCheckedDiscrimination,
                                "difficulty": isCheckedDifficulty,
                                "exclude": []
                              };
                              ref
                                  .read(questionBankProvider.notifier)
                                  .searchQuestions(filters)
                                  .then(
                                (value) {
                                  ref
                                      .read(
                                          questionSearchFilterProvider.notifier)
                                      .updateFilters(filters);
                                  ref
                                      .read(modalStateProvider.notifier)
                                      .updateModalState(ModalState.none);
                                },
                              );
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
