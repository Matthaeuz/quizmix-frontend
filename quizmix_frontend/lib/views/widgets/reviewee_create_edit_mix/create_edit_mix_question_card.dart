import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/questions/question.dart';
import 'package:quizmix_frontend/state/providers/api/base_url_provider.dart';
import 'package:quizmix_frontend/views/widgets/tiny_solid_button.dart';

class CreateEditMixQuestionCard extends ConsumerWidget {
  final Question questionDetails;
  final String action;
  final void Function() onClick;

  const CreateEditMixQuestionCard({
    Key? key,
    required this.questionDetails,
    required this.action,
    required this.onClick,
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
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Flexible(
                    child: Text(
                      'Category:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: getCategoryColor(questionDetails.category.name),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        questionDetails.category.name,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TinySolidButton(
                  text: action,
                  icon: action == "Add" ? Icons.add : Icons.remove,
                  buttonColor:
                      action == "Add" ? AppColors.mainColor : Colors.red,
                  onPressed: onClick,
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
