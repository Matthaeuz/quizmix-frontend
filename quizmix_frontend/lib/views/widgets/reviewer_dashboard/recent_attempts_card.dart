import 'package:flutter/material.dart';

class RecentAttemptsCard extends StatelessWidget {
  const RecentAttemptsCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Replace this with actual data you want to display
    List<Map<String, String>> data = [
      {
        'fullName': 'John Doe',
        'pretestScore': '95',
        'timeStarted': '09:00 AM',
        'timeFinished': '10:30 AM',
      },
      // Add more data entries as needed
    ];

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Attempts',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20.0),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('Full Name', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Pretest Score',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Time Started',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Time Finished',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 10.0),
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(data[index]['fullName'] ?? ''),
                    Text(data[index]['pretestScore'] ?? ''),
                    Text(data[index]['timeStarted'] ?? ''),
                    Text(data[index]['timeFinished'] ?? ''),
                  ],
                );
            },
          ),
        ],
      ),
    );
  }
}
