import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/base_url_provider.dart';

class RevieweeMixQuestionCard extends ConsumerWidget {
  final Question questionDetails;

  const RevieweeMixQuestionCard({
    Key? key,
    required this.questionDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseUrl = ref.watch(baseUrlProvider);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.mainColor,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Category:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: getCategoryColor(questionDetails.category),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    questionDetails.category,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF9854B2),
              ),
            ),
            child: Image.network(
              questionDetails.image!.contains(baseUrl)
                  ? questionDetails.image!
                  : baseUrl + questionDetails.image!,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
