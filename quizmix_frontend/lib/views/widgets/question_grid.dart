import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/widgets/solid_grid_item.dart';

class QuestionGrid extends ConsumerWidget {
  final void Function(int) onPressed;
  final int itemCount;

  const QuestionGrid(
      {super.key, required this.onPressed, required this.itemCount});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // try intrinsicheight also :))
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        // height: 20,
        /// The line `// height: 20,` is a commented out line of code. It is not doing anything in the
        /// current code. It is likely that it was added as a placeholder or for testing purposes, but
        /// it is not being used in the actual implementation of the `QuestionGrid` widget.
        constraints: const BoxConstraints(
          maxHeight: 80,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(
            color: AppColors.mainColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: SingleChildScrollView(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (int i = 0; i < itemCount; i++) ...[
                    SolidGridItem(
                      label: "${i + 1}",
                      onPressed: () => onPressed(i),
                    )
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
