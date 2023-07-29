import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:quizmix_frontend/constants/categories.constants.dart';
import 'package:quizmix_frontend/constants/colors.constants.dart';
import 'package:quizmix_frontend/views/widgets/solid_button.dart';
import 'package:file_picker/file_picker.dart';

class EditQuestionScreen extends StatefulWidget {
  final String category;

  const EditQuestionScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  _EditQuestionScreenState createState() => _EditQuestionScreenState();
}

class _EditQuestionScreenState extends State<EditQuestionScreen> {
  String _selectedAnswer = 'A';
  late String dropdownValue;
  Uint8List? selectedImageBytes;

  final TextEditingController questionController = TextEditingController(
    text:
        'Which of the following is the correct decimal fraction equal to hexadecimal fraction 0.248?',
  );
  final TextEditingController explanationController = TextEditingController(
    text: 'No Explanation',
  );
  final TextEditingController choiceAController = TextEditingController(
    text: '31/32',
  );
  final TextEditingController choiceBController = TextEditingController(
    text: '31/125',
  );
  final TextEditingController choiceCController = TextEditingController(
    text: '31/512',
  );
  final TextEditingController choiceDController = TextEditingController(
    text: '73/512',
  );

  @override
  void dispose() {
    // Clean up the TextEditingController when the widget is disposed.
    choiceAController.dispose();
    choiceBController.dispose();
    choiceCController.dispose();
    choiceDController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.category;
  }

  void _selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      setState(() {
        selectedImageBytes = file.bytes;
      });
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
        title: Row(
          children: [
            const Text(
              'Question Bank',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Poppins',
              ),
            ),
            IntrinsicWidth(
              child: Container(
                margin: const EdgeInsets.only(left: 25.0),
                padding: const EdgeInsets.all(10.0),
                child: Material(
                  color: getCategoryColor(dropdownValue),
                  borderRadius: BorderRadius.circular(10),
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    isExpanded: false,
                    underline: Container(),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: categories
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          color: getCategoryColor(value),
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            value,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SolidButton(
                    text: 'Remove Image',
                    onPressed: () {
                      setState(() {
                        selectedImageBytes = null;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  SolidButton(
                    text: 'Change Image',
                    onPressed: _selectImage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: questionController,
                style: const TextStyle(fontSize: 16),
                maxLines: null,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  hintText: 'Enter the explanation here',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.3,
                ),
                child: SingleChildScrollView(
                  child: selectedImageBytes != null
                      ? Image.memory(selectedImageBytes!, fit: BoxFit.cover)
                      : Container(
                          width: double.infinity,
                          height: 300,
                          color:
                              Colors.grey[300], // Placeholder background color
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image,
                                  size: 50,
                                  color: Colors.grey), // Placeholder icon
                              SizedBox(height: 10),
                              Text('No Image Selected',
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Choices",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  Row(
                    children: [
                      const Text("A) "),
                      Expanded(
                        child: buildChoice('Choice A', choiceAController),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("B) "),
                      Expanded(
                        child: buildChoice('Choice B', choiceBController),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("C) "),
                      Expanded(
                        child: buildChoice('Choice C', choiceCController),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("D) "),
                      Expanded(
                        child: buildChoice('Choice D', choiceDController),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    "Correct Answer: ",
                    style: TextStyle(fontSize: 18),
                  ),
                  DropdownButton<String>(
                    value: _selectedAnswer,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedAnswer = newValue!;
                      });
                    },
                    items: ['A', 'B', 'C', 'D']
                        .map<DropdownMenuItem<String>>((value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Explanation",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: explanationController,
                style: const TextStyle(fontSize: 16),
                maxLines: null,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(12.0),
                  hintText: 'Enter the explanation here',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 150,
                    child: SolidButton(
                      text: 'Save Changes',
                      onPressed: () {
                        // Save Changes logic here
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChoice(String choice, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
          hintText: 'Enter choice here',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
