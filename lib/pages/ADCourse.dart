import 'package:flutter/material.dart';
import 'package:haritha_connect/components/Components.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddCourseScreen extends StatefulWidget {
  @override
  _AddCourseScreenState createState() => _AddCourseScreenState();
}

class _AddCourseScreenState extends State<AddCourseScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseDescriptionController =
      TextEditingController();
  final TextEditingController _courseInstructorController =
      TextEditingController();
  final TextEditingController _courseDurationController =
      TextEditingController();
  // final TextEditingController _dateController = TextEditingController();

  String? selectedButton;
  void _onButtonPressed(String buttonText) {
    setState(() {
      selectedButton = buttonText;
    });
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   DateTime? pickedDate = await showDatePicker(
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(2000),
  //     lastDate: DateTime(2101),
  //   );

  //   if (pickedDate != null) {
  //     setState(() {
  //       _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
  //     });
  //   }
  // }

  void _submitForm() async {
    if (_formKey.currentState!.validate() &&
        _courseNameController.text.isNotEmpty &&
        _courseDescriptionController.text.isNotEmpty &&
        _courseInstructorController.text.isNotEmpty &&
        _courseDurationController.text.isNotEmpty &&
        selectedButton != null) {
      try {
        // Get the current user
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          DocumentReference userRef =
              FirebaseFirestore.instance.collection("user").doc(user.uid);

          // Prepare data
          Map<String, dynamic> courseData = {
            "name": _courseNameController.text,
            "description": _courseDescriptionController.text,
            "taughtBy": _courseInstructorController.text,
            "duration": _courseDurationController.text,
            "subject": selectedButton,
            "userCreated": userRef, // Reference to the current user
            "addedDate": FieldValue.serverTimestamp(), // Current date & time
          };

          await FirebaseFirestore.instance.collection("course").add(courseData);

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Course Added Successfully!")),
          );

          // Clear form fields
          _courseNameController.clear();
          _courseDescriptionController.clear();
          _courseInstructorController.clear();
          _courseDurationController.clear();
          setState(() {
            selectedButton = null;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("User not authenticated")),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error adding course: $e")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CurvedBackground(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Add Course",
                          style: Kheaderstyle,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 130,
            left: 20,
            right: 20,
            bottom: 20,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _courseNameController,
                        decoration: const InputDecoration(
                          labelText: "Course Name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _courseInstructorController,
                        decoration: const InputDecoration(
                          labelText: "Course Instructor",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _courseDurationController,
                        decoration: const InputDecoration(
                          labelText: "Course Duration",
                          border: OutlineInputBorder(),
                        ),
                      ),

                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _courseDescriptionController,
                        minLines: 1,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          labelText: "Course Description",
                          border: OutlineInputBorder(),
                        ),
                      ),

                      // const SizedBox(height: 30),

                      // TextFormField(
                      //   controller: _dateController,
                      //   readOnly: true,
                      //   decoration: const InputDecoration(
                      //     labelText: "Event Date",
                      //     border: OutlineInputBorder(),
                      //     suffixIcon: Icon(Icons.calendar_today),
                      //   ),
                      //   onTap: () => _selectDate(context),
                      //   validator: (value) =>
                      //       value!.isEmpty ? "Please select event date" : null,
                      // ),
                      const SizedBox(height: 30),
                      // Skills Section
                      Text(
                        "Subject",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            spacing: 20,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  _onButtonPressed("AI");
                                },
                                style: selectedButton == "AI"
                                    ? kOutlineButtonStyle.copyWith(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                Colors.blue),
                                        foregroundColor:
                                            WidgetStateProperty.all(
                                                Colors.white),
                                      )
                                    : kOutlineButtonStyle,
                                child: Text("AI"),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  _onButtonPressed("Machine Learning");
                                },
                                style: selectedButton == "Machine Learning"
                                    ? kOutlineButtonStyle.copyWith(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                Colors.blue),
                                        foregroundColor:
                                            WidgetStateProperty.all(
                                                Colors.white),
                                      )
                                    : kOutlineButtonStyle,
                                child: Text("Machine Learning"),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  _onButtonPressed("Data Science");
                                },
                                style: selectedButton == "Data Science"
                                    ? kOutlineButtonStyle.copyWith(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                Colors.blue),
                                        foregroundColor:
                                            WidgetStateProperty.all(
                                                Colors.white),
                                      )
                                    : kOutlineButtonStyle,
                                child: Text("Data Science"),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  _onButtonPressed("Computer Science");
                                },
                                style: selectedButton == "Computer Science"
                                    ? kOutlineButtonStyle.copyWith(
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                                Colors.blue),
                                        foregroundColor:
                                            WidgetStateProperty.all(
                                                Colors.white),
                                      )
                                    : kOutlineButtonStyle,
                                child: Text("Computer Science"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          child: Text("Add Course"),
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
