import 'package:flutter/material.dart';

class RevieweeDetailCard extends StatelessWidget {
  final String title;
  final String? image;

  const RevieweeDetailCard(
      {super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle box onPress
      },
      child: Container(
        width: 200,
        height: 200,
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: image == null
                      ? Image.asset(
                          'lib/assets/images/default_pic.png',
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          image!,
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
