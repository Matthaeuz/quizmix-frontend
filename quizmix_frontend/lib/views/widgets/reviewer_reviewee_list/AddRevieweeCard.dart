import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/state/models/users/user.dart';

class AddRevieweeCard extends StatelessWidget {
  final bool isSelected;
  final ValueChanged<bool> onCheckboxChanged;
  final User reviewee;

  const AddRevieweeCard({
    Key? key,
    required this.reviewee,
    required this.isSelected,
    required this.onCheckboxChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white, // Set the background color to white
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.grey),
            borderRadius: const BorderRadius.all(Radius.circular(5))),
        child: Row(
          children: [
            SizedBox(
              width: 75,
              height: 75,
              child: Image.network(
                'lib/assets/images/default_pic.png',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                reviewee.fullName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Checkbox(
                value: isSelected,
                onChanged: (value) {
                  onCheckboxChanged(value ?? false);
                },
                activeColor: AppColors.mainColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
