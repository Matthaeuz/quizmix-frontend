import 'package:flutter/material.dart';

class ProfileArea extends StatelessWidget {
  const ProfileArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Circular Picture
          CircleAvatar(
            radius: 30,
            // backgroundImage:
            //     AssetImage('assets/images/ProfilePicture.jpg'),
          ),
          SizedBox(width: 16),
          // Text Information
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Aloysius Matthew A. Beronque',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Text(
                'aloysiusmatthew1@gmail.com',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
