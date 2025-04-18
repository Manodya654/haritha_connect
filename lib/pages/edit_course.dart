import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ui_connect/pages/courses.dart';
import 'package:ui_connect/pages/jobs.dart';
import '../components/Components.dart';

class EditCourse extends StatefulWidget {
  final String CourseId;
  const EditCourse({required this.CourseId});

  @override
  State<EditCourse> createState() => _EditCourseState();
}

class _EditCourseState extends State<EditCourse> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _courseNameController = TextEditingController();
  final TextEditingController _courseDescriptionController =
      TextEditingController();
  final TextEditingController _courseInstructorController =
      TextEditingController();
  final TextEditingController _courseDurationController =
      TextEditingController();
  final TextEditingController _courseJoinLinkController =
      TextEditingController();

  String? selectedButton;
  String? _savedImagePath;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _loadCourseData();
  }

  Future<void> _loadCourseData() async {
    DocumentSnapshot courseDoc = await FirebaseFirestore.instance
        .collection("course")
        .doc(widget.CourseId)
        .get();
    if (courseDoc.exists) {
      Map<String, dynamic> data = courseDoc.data() as Map<String, dynamic>;
      setState(() {
        _courseNameController.text = data['name'] ?? '';
        _courseDescriptionController.text = data['description'] ?? '';
        _courseInstructorController.text = data['taughtBy'] ?? '';
        _courseDurationController.text = data['duration'] ?? '';
        _courseJoinLinkController.text = data['joinLink'] ?? '';
        selectedButton = data['subject'];
        _savedImagePath = data['coursePic'];
        if (_savedImagePath != null) {
          _selectedImage = File(_savedImagePath!);
        }
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      await _saveImageLocally(imageFile);

      // Ensure UI updates with the new image
      setState(() {
        _selectedImage = imageFile;
        _savedImagePath = pickedFile.path; // Update the path
      });
    }
  }

  Future<void> _saveImageLocally(File imageFile) async {
    if (await Permission.storage.request().isGranted) {
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        Directory? externalDir = await getExternalStorageDirectory();
        final customDir =
            Directory('${externalDir!.path}/ui_connect/CourseImages');
        await customDir.create(recursive: true);

        if (_savedImagePath != null && File(_savedImagePath!).existsSync()) {
          await File(_savedImagePath!).delete();
        }

        String filePath =
            "${customDir.path}/${userId}_${DateTime.now().millisecondsSinceEpoch}.jpg";
        File savedImage = await imageFile.copy(filePath);

        setState(() {
          _selectedImage = savedImage;
          _savedImagePath = filePath;
        });
      }
    }
  }

  Future<void> _updateCourse() async {
    if (_formKey.currentState!.validate() && selectedButton != null) {
      try {
        DocumentReference courseRef = FirebaseFirestore.instance
            .collection("course")
            .doc(widget.CourseId);
        await courseRef.update({
          "name": _courseNameController.text,
          "description": _courseDescriptionController.text,
          "taughtBy": _courseInstructorController.text,
          "duration": _courseDurationController.text,
          "joinLink": _courseJoinLinkController.text,
          "subject": selectedButton,
          "coursePic": _savedImagePath,
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Course Updated Successfully!")));

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Courses()),
        );
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error updating course: $e")));
      }
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CurvedBackground(
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Jobs()),
                        );
                      },
                      icon: Icon(Icons.arrow_back),
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Edit Course",
                        style: Kheaderstyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _courseNameController,
                        decoration: InputDecoration(labelText: "Course Name"),
                      ),
                      TextFormField(
                        controller: _courseInstructorController,
                        decoration: InputDecoration(labelText: "Instructor"),
                      ),
                      TextFormField(
                        controller: _courseDurationController,
                        decoration: InputDecoration(labelText: "Duration"),
                      ),
                      TextFormField(
                        controller: _courseDescriptionController,
                        decoration: InputDecoration(labelText: "Description"),
                      ),
                      TextFormField(
                        controller: _courseJoinLinkController,
                        decoration: InputDecoration(labelText: "Join Link"),
                      ),
                      SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          spacing: 10,
                          children: [
                            "AI",
                            "Machine Learning",
                            "Data Science",
                            "Computer Science"
                          ].map((subject) {
                            return ElevatedButton(
                              onPressed: () => setState(() => selectedButton = subject),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: selectedButton == subject ? Colors.blue : Colors.white,
                              ),
                              child: Text(subject),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _pickImage,
                        child: Text("Select Image"),
                      ),
                      _selectedImage != null
                          ? Image.file(_selectedImage!, height: 150)
                          : Text("No Image Selected"),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _updateCourse,
                        child: Text("Edit Course"),
                      ),
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
