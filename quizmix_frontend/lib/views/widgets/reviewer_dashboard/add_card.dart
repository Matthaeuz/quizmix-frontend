import 'package:flutter/material.dart';
import 'package:quizmix_frontend/views/screens/reviewer/tos_modal_screen.dart';

class AddCard extends StatelessWidget {
  const AddCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TosModalScreen()));
      },
      child: Container(
        width: 200,
        height: 200,
        color: Colors.white,
        margin: const EdgeInsets.only(right: 25),
        child: const Icon(Icons.add, size: 100, color: Colors.black),
      ),
    );
  }
}
