import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/providers/questions/current_question_provider.dart';
import 'package:quizmix_frontend/state/providers/questions/question_bank_provider.dart';
import 'package:quizmix_frontend/state/providers/ui/modal_state_provider.dart';
import 'package:quizmix_frontend/views/widgets/empty_data_placeholder.dart';
import 'package:quizmix_frontend/views/widgets/question_bank/question_bank_item.dart';
import 'package:quizmix_frontend/views/widgets/responsive_solid_button.dart';

class ReviewerQuestionBankTab extends ConsumerStatefulWidget {
  const ReviewerQuestionBankTab({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ReviewerQuestionBankTab> createState() =>
      _ReviewerQuestionBankTabState();
}

class _ReviewerQuestionBankTabState
    extends ConsumerState<ReviewerQuestionBankTab> {
  final ScrollController _scrollController = ScrollController();
  bool shouldApplyPadding = true;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset > 0) {
        setState(() {
          shouldApplyPadding = false;
        });
      } else {
        setState(() {
          shouldApplyPadding = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  double calculateAspectRatio(int axisCount, double width) {
    if (axisCount == 1) {
      return 2.5 + (width - 400) * 0.0075;
    } else if (axisCount == 2) {
      return 2.5 + ((width - 800) / 2) * 0.0075;
    } else if (axisCount == 3) {
      return 2.5 + ((width - 1160) / 3) * 0.0075;
    }
    return 2.5;
  }

  double calculateRightMargin(int axisCount, double width) {
    if (axisCount == 1) {
      return width - 400;
    } else if (axisCount == 2) {
      return (width - 800) / 2;
    } else if (axisCount == 3) {
      return (width - 1160) / 3;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final questions = ref.watch(questionBankProvider);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: AppColors.mainColor,
      child: questions.when(
        data: (data) {
          final hasQuestions =
              ref.read(questionBankProvider.notifier).hasQuestions;
          return Stack(
            children: [
              data.isEmpty || !hasQuestions
                  ? const Center(
                      child: SingleChildScrollView(
                      child: EmptyDataPlaceholder(
                          message: "There are no questions in the bank."),
                    ))
                  : LayoutBuilder(builder: ((context, constraints) {
                      final crossAxisCount = constraints.maxWidth > 1160
                          ? 3
                          : constraints.maxWidth > 800
                              ? 2
                              : 1;
                      double childAspectRatio = calculateAspectRatio(
                          crossAxisCount, constraints.maxWidth);
                      double rightMargin = calculateRightMargin(
                          crossAxisCount, constraints.maxWidth);
                      return Padding(
                        padding: EdgeInsets.fromLTRB(
                          24,
                          shouldApplyPadding && screenHeight > 160 ? 100 : 0,
                          24,
                          0,
                        ),
                        child: GridView.builder(
                          controller: _scrollController,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: childAspectRatio,
                            crossAxisSpacing: 24.0,
                            mainAxisSpacing: 24.0,
                            crossAxisCount: crossAxisCount,
                          ),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  EdgeInsets.fromLTRB(0, 0, rightMargin, 0),
                              child: QuestionBankItem(question: data[index]),
                            );
                          },
                        ),
                      );
                    })),
              // Search Input & Add Mix
              screenHeight > 160
                  ? Container(
                      padding: const EdgeInsets.fromLTRB(28, 24, 28, 24),
                      color: AppColors.mainColor.withOpacity(0.5),
                      child: Row(
                        children: [
                          Expanded(
                            flex: screenWidth > 880 ? 0 : 1,
                            child: SizedBox(
                              width: screenWidth > 880 ? 480 : null,
                              child: TextField(
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: AppColors.white,
                                  hintText: 'Search Questions',
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
                                      .read(questionBankProvider.notifier)
                                      .textSearchQuestions(value);
                                  setState(() {
                                    shouldApplyPadding = true;
                                  });
                                },
                              ),
                            ),
                          ),
                          screenWidth > 880 ? const Spacer() : const SizedBox(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                            child: ResponsiveSolidButton(
                              text: "Advanced Search",
                              condition: screenWidth > 1260,
                              icon: const Icon(Icons.search),
                              elevation: 8.0,
                              onPressed: () {
                                ref
                                    .read(modalStateProvider.notifier)
                                    .updateModalState(
                                        ModalState.advancedSearch);
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 0, 0, 0),
                            child: ResponsiveSolidButton(
                              text: "Manage Question Bank",
                              condition: screenWidth > 1260,
                              icon: const Icon(Icons.edit),
                              elevation: 8.0,
                              onPressed: () {
                                final RenderBox button =
                                    context.findRenderObject() as RenderBox;
                                final Offset offset =
                                    button.localToGlobal(Offset.zero);

                                showMenu(
                                  context: context,
                                  position: RelativeRect.fromLTRB(
                                      offset.dx, 72, 0, 0),
                                  items: [
                                    "Add Question",
                                    "Upload PDFs",
                                    "Retrain Model",
                                  ].map((item) {
                                    return PopupMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          color: AppColors.white,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ).then((selectedValue) {
                                  if (selectedValue == "Add Question") {
                                    ref
                                        .read(currentQuestionProvider.notifier)
                                        .updateCurrentQuestion(null);
                                    ref
                                        .read(modalStateProvider.notifier)
                                        .updateModalState(
                                            ModalState.createEditQuestion);
                                  } else if (selectedValue == "Upload PDFs") {
                                    ref
                                        .read(modalStateProvider.notifier)
                                        .updateModalState(
                                            ModalState.uploadPDFs);
                                  } else if (selectedValue == "Retrain Model") {
                                    ref
                                        .read(modalStateProvider.notifier)
                                        .updateModalState(
                                            ModalState.retrainModel);
                                  }
                                });
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
