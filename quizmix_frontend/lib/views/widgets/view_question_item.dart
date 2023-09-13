import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';

class ViewQuestionItem extends ConsumerWidget {
  final int questionNum;
  final Question questionDetails;
  final void Function() onClick;
  final bool condition;

  const ViewQuestionItem({
    Key? key,
    required this.questionNum,
    required this.questionDetails,
    required this.onClick,
    required this.condition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: onClick,
        child: Container(
          padding: const EdgeInsets.all(12),
          constraints: const BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: condition
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Question No. $questionNum",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Category: ${questionDetails.category.name}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      questionDetails.question,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: Text(
                    "${questionDetails.id}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
