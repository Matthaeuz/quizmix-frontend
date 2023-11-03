import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/api/helpers/datetime_convert.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/rest_client_provider.dart';
import 'package:quizmix_frontend/state/providers/auth/auth_token_provider.dart';
import 'package:quizmix_frontend/state/providers/mix_questions/current_viewed_mix_question_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/available_mix_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/mix_question_search_filter_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/reviewee_mixes_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/process_state_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewee/create_edit_mix_screen.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/question_grid.dart';
import 'package:quizmix_frontend/views/widgets/responsive_solid_button.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_view_mix/view_mix_question_container.dart';
import 'package:quizmix_frontend/views/widgets/view_question_item.dart';

class ViewMixScreen extends ConsumerStatefulWidget {
  const ViewMixScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ViewMixScreen> createState() => _ViewMixScreenState();
}

class _ViewMixScreenState extends ConsumerState<ViewMixScreen> {
  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final client = ref.watch(restClientProvider);
    final token = ref.watch(authTokenProvider).accessToken;
    final processState = ref.watch(processStateProvider);
    final currentMix = ref.watch(currentMixProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: screenWidth > 920 ? 1 : 3,
            child: Column(
              children: [
                Expanded(
                  flex: screenHeight > 360 ? 0 : 1,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton(
                                onPressed: () {
                                  ref
                                      .read(currentViewedMixQuestionProvider
                                          .notifier)
                                      .updateCurrentViewedQuestion({
                                    "qnum": 0,
                                    "question": Question.base()
                                  });
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
                              Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  color: AppColors.fourthColor,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: currentMix!.image != null
                                    ? Image(
                                        image: NetworkImage(currentMix.image!),
                                        fit: BoxFit.cover,
                                      )
                                    : Center(
                                        child: Text(
                                          currentMix.title[0],
                                          style: const TextStyle(
                                            color: AppColors.black,
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 24),
                                Text(
                                  currentMix.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "${currentMix.numQuestions} ${currentMix.numQuestions > 1 ? "questions" : "question"}, ${currentMix.numCategories} ${currentMix.numCategories > 1 ? "categories" : "category"}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  "Created on: ${dateTimeToWordDate(currentMix.createdOn)}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    ResponsiveSolidButton(
                                      text: "Edit Mix",
                                      condition: screenWidth > 1000,
                                      icon: const Icon(Icons.edit),
                                      isUnpressable:
                                          processState == ProcessState.done
                                              ? false
                                              : true,
                                      elevation: 8.0,
                                      onPressed: () {
                                        ref
                                            .read(currentMixProvider.notifier)
                                            .updateCurrentMix(currentMix);
                                        ref
                                            .read(availableMixQuestionsProvider
                                                .notifier)
                                            .fetchQuestions();
                                        ref
                                            .read(currentMixQuestionsProvider
                                                .notifier)
                                            .fetchQuestions();
                                        ref
                                            .read(
                                                mixQuestionSearchFilterProvider
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
                                    const SizedBox(width: 16),
                                    ResponsiveSolidButton(
                                      text: "Delete Mix",
                                      condition: screenWidth > 1000,
                                      icon: const Icon(Icons.delete),
                                      backgroundColor: AppColors.red,
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
                                        try {
                                          await client.deleteMixById(
                                              token, currentMix.id);

                                          ref
                                              .read(revieweeMixesProvider
                                                  .notifier)
                                              .fetchMixes()
                                              .then(
                                            (value) {
                                              ref
                                                  .read(processStateProvider
                                                      .notifier)
                                                  .updateProcessState(
                                                      ProcessState.done);
                                              Navigator.pop(context);
                                            },
                                          );
                                        } catch (err) {
                                          ref
                                              .read(
                                                  processStateProvider.notifier)
                                              .updateProcessState(
                                                  ProcessState.done);
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                QuestionGrid(
                  itemCount: currentMix.questions.length,
                  onPressed: (index) {
                  final double offset = (index - 1) *
                      136; //offset = (index - 1) * (itemheight + spacing[sizedbox])
                  scrollController.animateTo(
                    offset,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }),
                const ViewMixQuestionContainer(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: AppColors.mainColor,
              child: currentMix.questions.isNotEmpty
                  ? ListView.builder(
                      controller: scrollController,
                      itemCount: currentMix.questions.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: index == 0 ? 24 : 0,
                              bottom: index == currentMix.questions.length - 1
                                  ? 24
                                  : 0,
                            ),
                            child: ViewQuestionItem(
                              questionNum: index + 1,
                              questionDetails: currentMix.questions[index],
                              condition: screenWidth > 920,
                              onClick: () {
                                ref
                                    .read(currentViewedMixQuestionProvider
                                        .notifier)
                                    .updateCurrentViewedQuestion({
                                  "qnum": index + 1,
                                  "question": currentMix.questions[index]
                                });
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
                            message: "There are no questions in your Mix",
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
