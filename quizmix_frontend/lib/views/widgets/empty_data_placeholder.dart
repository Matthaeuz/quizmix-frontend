import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';

class EmptyDataPlaceholder extends StatelessWidget {
  final String message;

  const EmptyDataPlaceholder({Key? key, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 25),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.info_outlined,
                  size: 200, color: AppColors.mainColor),
              const SizedBox(height: 25),
              Text(
                message,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24, 
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
