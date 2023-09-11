import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/screens/reviewer/add_reviewee_screen.dart';
import 'package:quizmix_frontend/views/screens/reviewer/tos_modal_screen.dart';

class AddCard extends ConsumerStatefulWidget {
  final String type;

  const AddCard({super.key, this.type = "quizzes"});

  @override
  AddCardState createState() => AddCardState();
}

class AddCardState extends ConsumerState<AddCard> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.type == "quizzes") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TosModalScreen(),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddRevieweeScreen(),
            ),
          );
        }
      },
      onHover: (value) {
        setState(() {
          isHovering = value;
        });
      },
      child: Container(
        width: 200,
        height: 200,
        color: Colors.white,
        child: Material(
          color:
              isHovering ? AppColors.grey.withOpacity(0.1) : Colors.transparent,
          child: const Center(
            child: Icon(Icons.add, size: 100, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
