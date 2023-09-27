import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';

class UploadedQuestionItemContainer extends ConsumerWidget {
  final Question currentQuestion;
  final int index;

  const UploadedQuestionItemContainer({
    super.key,
    required this.currentQuestion,
    required this.index,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final choiceLetters = ['A', 'B', 'C', 'D'];

    return Container(
      width: 796,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Question ${currentQuestion.id}',
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Category: ${currentQuestion.category.name}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 12),
          Text(
            currentQuestion.question,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 12),
          currentQuestion.image != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Image.network(
                    currentQuestion.image!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              : const SizedBox(),
          for (var i = 0; i < currentQuestion.choices.length; i++) ...[
            Text(
              '${choiceLetters[i]}. ${currentQuestion.choices[i]}',
              style: const TextStyle(fontSize: 16),
            ),
          ],
          const SizedBox(height: 12),
          Text(
            'Answer: ${currentQuestion.answer.toUpperCase()}. ${currentQuestion.choices[choiceLetters.indexOf(currentQuestion.answer.toUpperCase())]}',
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
