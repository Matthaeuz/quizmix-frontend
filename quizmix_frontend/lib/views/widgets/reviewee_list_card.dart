import 'package:flutter/material.dart';
import 'package:quizmix_frontend/state/models/reviewees/reviewee.dart';

class RevieweeListCard extends StatelessWidget {
  final Reviewee revieweeDetails;

  const RevieweeListCard({
    Key? key,
    required this.revieweeDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle card press
      },
      child: Material(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        child: Container(
          padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Row(
            children: [
              // 1st column - Picture
              SizedBox(
                  width: 75,
                  height: 75,
                  child: revieweeDetails.user.image != null
                      ? Image.network(
                          revieweeDetails.user.image!,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'lib/assets/images/default_pic.png',
                          fit: BoxFit.cover,
                        )),
              const SizedBox(width: 25),
              // 2nd column - Text
              Expanded(
                child: Text(
                  revieweeDetails.user.fullName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // 3rd column - Next Arrow
              const Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
