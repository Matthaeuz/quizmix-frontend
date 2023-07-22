import 'package:flutter/material.dart';

class AddCard extends StatelessWidget {
  const AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: Colors.white,
      margin: const EdgeInsets.only(right: 25),
      child: const Icon(Icons.add, size: 100, color: Colors.black),
    );
  }
}
