import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/mixes/available_mix_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/mix_question_search_filter_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/reviewee_mixes_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewee/create_edit_mix_screen.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_mixes_tab/reviewee_mix_item.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class RevieweeMixesTab extends ConsumerStatefulWidget {
  const RevieweeMixesTab({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RevieweeMixesTab> createState() => _RevieweeMixesTabState();
}

class _RevieweeMixesTabState extends ConsumerState<RevieweeMixesTab> {
  @override
  Widget build(BuildContext context) {
    final mixes = ref.watch(revieweeMixesProvider);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: AppColors.mainColor,
      child: mixes.when(
        data: (data) {
          final allMixesLen =
              ref.read(revieweeMixesProvider.notifier).allMixes.length;
          return Stack(
            children: [
              data.isEmpty && allMixesLen == 0
                  ? const Center(
                      child: SingleChildScrollView(
                        child: EmptyDataPlaceholder(
                          message: "You currently have no mixes",
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                      child: CustomScrollView(
                        slivers: [
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(
                                  0, screenHeight > 160 ? 100 : 0, 0, 0),
                              child: Wrap(
                                spacing: 24.0,
                                runSpacing: 24.0,
                                children: [
                                  for (var index = 0;
                                      index < data.length;
                                      index++) ...[
                                    RevieweeMixItem(mix: data[index]),
                                  ]
                                ],
                              ),
                            ),
                          ),
                          const SliverFillRemaining(
                            hasScrollBody: false,
                            child: SizedBox(),
                          ),
                        ],
                      ),
                    ),
              // Search Input & Add Mix
              screenHeight > 160
                  ? Container(
                      padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
                      color: AppColors.mainColor.withOpacity(0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: screenWidth > 860 &&
                                    data.isNotEmpty &&
                                    allMixesLen > 0
                                ? 0
                                : 1,
                            child: data.isEmpty && allMixesLen == 0
                                ? const SizedBox()
                                : SizedBox(
                                    width: screenWidth > 860 ? 480 : null,
                                    child: TextField(
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: AppColors.white,
                                        hintText: 'Search Mixes',
                                        prefixIcon: Icon(
                                          Icons.search,
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                        ),
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 8),
                                      ),
                                      onChanged: (value) {
                                        ref
                                            .read(
                                                revieweeMixesProvider.notifier)
                                            .searchMixes(value);
                                      },
                                    ),
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                            child: SolidButton(
                              text: "Add Mix",
                              icon: const Icon(Icons.add),
                              elevation: 8.0,
                              onPressed: () {
                                ref
                                    .read(currentMixProvider.notifier)
                                    .updateCurrentMix(null);
                                ref
                                    .read(
                                        availableMixQuestionsProvider.notifier)
                                    .fetchQuestions();
                                ref
                                    .read(currentMixQuestionsProvider.notifier)
                                    .fetchQuestions();
                                ref
                                    .read(mixQuestionSearchFilterProvider
                                        .notifier)
                                    .initializeFilters();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateEditMixScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          );
        },
        loading: () => const Center(
          child: SizedBox(
            width: 48.0,
            height: 48.0,
            child: CircularProgressIndicator(color: AppColors.white),
          ),
        ),
        error: (err, stack) => const Center(
          child: SingleChildScrollView(
            child: EmptyDataPlaceholder(
              message: "Please try again later",
            ),
          ),
        ),
      ),
    );
  }
}
