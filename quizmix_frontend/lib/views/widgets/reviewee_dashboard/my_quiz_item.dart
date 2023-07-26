import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';

class MyQuizItem extends StatelessWidget {
  final String title;

  MyQuizItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5), // Add border radius of 5
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppColors.fourthColor,
              borderRadius: BorderRadius.circular(5), // Add border radius of 5
            ),
            child: Center(
              child: Text(
                title.isNotEmpty ? title[0] : '',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SolidButton(
            onPressed: () {
              // Handle Review Attempts button press
            },
            text: 'Review Attempts',
            width: 150,
          ),
          const SizedBox(width: 12),
          SolidButton(
            onPressed: () {
              // Handle Review Attempts button press
            },
            text: 'Answer',
            width: 150,
          ),
        ],
      ),
    );
  }
}
