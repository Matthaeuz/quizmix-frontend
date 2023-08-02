import 'package:flutter/material.dart';
import 'package:quizmix_frontend/state/models/reviewees/reviewee.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';

class AddRevieweeCard extends StatelessWidget {
  final bool isSelected;
  final ValueChanged<bool> onCheckboxChanged;

  const AddRevieweeCard({
    Key? key,
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
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Row(
          children: [
            SizedBox(
              width: 75,
              height: 75,
              child: Image.network(
                'lib/assets/images/profile_pictures/aaron.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                "Aaron Benjmin R. Alcuitas",
                style: TextStyle(
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
