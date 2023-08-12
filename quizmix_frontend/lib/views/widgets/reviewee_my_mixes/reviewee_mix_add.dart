import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/providers/mixes/available_mix_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/current_mix_questions_provider.dart';
import 'package:quizmix_frontend/state/providers/mixes/mix_question_search_filter_provider.dart';
import 'package:quizmix_frontend/views/screens/reviewee/create_edit_mix_screen.dart';

class RevieweeMixAdd extends ConsumerWidget {
  const RevieweeMixAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(currentMixProvider.notifier).updateCurrentMix(null);
        ref.read(availableMixQuestionsProvider.notifier).fetchQuestions();
        ref.read(currentMixQuestionsProvider.notifier).fetchQuestions();
        ref.read(mixQuestionSearchFilterProvider.notifier).initializeFilters();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreateEditMixScreen(),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5), // Add border radius of 5
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 70,
              height: 70,
              child: Center(
                child: Icon(Icons.add, size: 50, color: Colors.black),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Text(
                "Create New Mix",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
