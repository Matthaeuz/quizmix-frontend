import 'package:flutter/material.dart';
import 'package:quizmix_frontend/state/models/users/user.dart';
import 'package:quizmix_frontend/views/widgets/reviewer_reviewee_list/AddRevieweeCard.dart';
import 'package:quizmix_frontend/views/widgets/search_input.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';
import 'package:quizmix_frontend/state/models/reviewees/reviewee.dart';
import 'package:quizmix_frontend/views/widgets/reviewee_list_card.dart';

class Reviewee {
  final String name;
  final String image;
  bool isChecked; // Add the isChecked property

  Reviewee({
    required this.name,
    required this.image,
    this.isChecked = false, // Set the default value to false
  });
}

class AddRevieweeScreen extends StatefulWidget {
  const AddRevieweeScreen({Key? key}) : super(key: key);

  @override
  State<AddRevieweeScreen> createState() => _AddRevieweeScreenState();
}

class _AddRevieweeScreenState extends State<AddRevieweeScreen> {
  List<Reviewee> selectedReviewees = [];

  List<Reviewee> reviewees = [
    Reviewee(name: 'Reviewee 1', image: 'path/to/image1.jpg'),
    Reviewee(name: 'Reviewee 2', image: 'path/to/image2.jpg'),
    Reviewee(name: 'Reviewee 3', image: 'path/to/image3.jpg'),
    Reviewee(name: 'Reviewee 4', image: 'path/to/image3.jpg'),
    Reviewee(name: 'Reviewee 5', image: 'path/to/image3.jpg'),
    Reviewee(name: 'Reviewee 6', image: 'path/to/image3.jpg'),
    Reviewee(name: 'Reviewee 7', image: 'path/to/image3.jpg'),
    Reviewee(name: 'Reviewee 8', image: 'path/to/image3.jpg'),
    Reviewee(name: 'Reviewee 9', image: 'path/to/image3.jpg'),
    Reviewee(name: 'Reviewee 10', image: 'path/to/image3.jpg'),
    Reviewee(name: 'Reviewee 11', image: 'path/to/image3.jpg'),
  ];

  late List<bool> isCheckedList;

  @override
  void initState() {
    super.initState();
    // Initialize isCheckedList here, after the widget is fully constructed
    isCheckedList = List.generate(reviewees.length, (index) => false);
  }

  void printSelectedReviewees() {
    for (var reviewee in selectedReviewees) {
      print(reviewee.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Search Reviewee',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Poppins',
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SearchInput(
                      onChanged: (value) {
                        // Handle search input changes
                      },
                    ),
                  ),
                ),
                SolidButton(
                  text: 'Add Selected',
                  onPressed: () {
                    // Handle "Add Reviewee" button press
                    selectedReviewees.clear();
                    for (int i = 0; i < isCheckedList.length; i++) {
                      if (isCheckedList[i]) {
                        selectedReviewees.add(reviewees[i]);
                      }
                    }
                    printSelectedReviewees();
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: reviewees.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 25),
                itemBuilder: (context, index) {
                  return AddRevieweeCard(
                    isSelected: isCheckedList[index],
                    onCheckboxChanged: (value) {
                      setState(() {
                        isCheckedList[index] = value;
                      });
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
