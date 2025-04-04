import 'package:flutter/material.dart';
import 'package:ui_connect/components/Components.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ui_connect/pages/profile_page.dart';
import '../service/Database.dart';

import 'package:firebase_auth/firebase_auth.dart';

// packages for image/ cv uploading and storing
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AddProfileScreen extends StatefulWidget {
  @override
  _AddProfileScreenState createState() => _AddProfileScreenState();
}

class _AddProfileScreenState extends State<AddProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _savedImagePath;
  File? _selectedImage;
  String? _savedResumePath;
  File? _selectedResume;

  TextEditingController _TitleController = TextEditingController();
  TextEditingController _NameController = TextEditingController();
  TextEditingController _AboutController = TextEditingController();

  // functions to get image from user
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      await _saveImageLocally(imageFile);
    }
  }

// function to store image locally
  Future<void> _saveImageLocally(File imageFile) async {
    try {
      // Request storage permissions (needed for Android)
      if (await Permission.storage.request().isGranted) {
        String? userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          // Get external storage directory
          Directory? externalDir = await getExternalStorageDirectory();

          // Ensure the directory exists and define custom path
          final customDir =
              Directory('${externalDir!.path}/ui_connect/ProfileImage');
          await customDir.create(recursive: true);

          String filePath = "${customDir.path}/${userId}_prodilePic.jpg";

          // Save the image to the new path
          File savedImage = await imageFile.copy(filePath);

          // Update UI with the new image
          setState(() {
            _selectedImage = savedImage;
            _savedImagePath = filePath;
          });

          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Image saved successfully!")));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Error Retrieving User Information")));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Storage permission denied!")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error saving image: $e")));
    }
  }

  Future<void> _pickResume() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      await _saveResumeLocally(file);
    }
  }

  Future<void> _saveResumeLocally(File file) async {
    try {
      if (await Permission.storage.request().isGranted) {
        String? userId = FirebaseAuth.instance.currentUser?.uid;
        if (userId != null) {
          Directory? externalDir = await getExternalStorageDirectory();
          final customDir = Directory('${externalDir!.path}/ui_connect/Resume');
          await customDir.create(recursive: true);

          String filePath = "${customDir.path}/${userId}_resume.pdf";
          File savedFile = await file.copy(filePath);

          setState(() {
            _selectedResume = savedFile;
            _savedResumePath = filePath;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Resume saved successfully!")),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Storage permission denied!")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving resume: $e")),
      );
    }
  }

  List<String> skills = [
    "HTML",
    "PHP",
    "Java",
    "C",
    "React",
    "Dart",
    "Python",
    "AI",
    "C#",
    "Javascript",
    "Ruby",
  ];

  List<String> selectedSkills = [];

  void updateSelectedSkills(String skill) {
    setState(() {
      if (selectedSkills.contains(skill)) {
        selectedSkills.remove(skill);
      } else {
        selectedSkills.add(skill);
      }
    });
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
                      // IconButton(
                      //   onPressed: () {
                      //     Navigator.pushReplacement(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => ProfilePage()),
                      //     );
                      //   },
                      //   icon: Icon(Icons.arrow_back),
                      //   color: Colors.white,
                      // ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Add Profile",
                          style: Kheaderstyle,
                        ),
                      ),
                    ],
                  ),
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
                        controller: _TitleController,
                        decoration: const InputDecoration(
                          labelText: "Title",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _NameController,
                        decoration: const InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _AboutController,
                        decoration: const InputDecoration(
                          labelText: "About",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // Skills Section
                      Text(
                        "Skills",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 10,
                        children: skills.map((skill) {
                          bool isSelected = selectedSkills.contains(skill);
                          return OutlinedButton(
                            onPressed: () {
                              updateSelectedSkills(skill);
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor:
                                  isSelected ? Colors.blue : Colors.white,
                              foregroundColor:
                                  isSelected ? Colors.white : Colors.black,
                            ),
                            child: Text(skill),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _pickImage,
                          child: Text("Select Image"),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _selectedImage != null
                          ? Image.file(_selectedImage!, height: 150)
                          : Text("No Image Selected",
                              style: TextStyle(color: Colors.grey)),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _pickResume,
                          child: Text("Select Resume"),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _selectedResume != null
                          ? Text(
                              "Resume Selected: ${_selectedResume!.path.split('/').last}")
                          : Text("No Resume Selected",
                              style: TextStyle(color: Colors.grey)),

                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_savedImagePath != null &&
                                _savedResumePath != null) {
                              try {
                                // Get the current user
                                User? user = FirebaseAuth.instance.currentUser;

                                if (user != null) {
                                  String id = user.uid;

                                  Map<String, dynamic> addprofileMap = {
                                    "id": id,
                                    "Title": _TitleController.text,
                                    "Name": _NameController.text,
                                    "About": _AboutController.text,
                                    "Skills": selectedSkills,
                                    "profilePic": _savedImagePath,
                                    "resume": _savedResumePath,
                                    "initialLogin": false,
                                  };

                                  await DatabaseMethods()
                                      .updateProfile(addprofileMap, id)
                                      .then((value) {
                                    Fluttertoast.showToast(
                                        msg: "Profile Added Successfully",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);

                                    _AboutController.clear();
                                    _NameController.clear();
                                    _TitleController.clear();

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProfilePage()),
                                    );

                                    setState(() {
                                      _savedImagePath = null;
                                      _selectedImage = null;
                                      _savedResumePath = null;
                                      _selectedResume = null;
                                    });

                                    @override
                                    void dispose() {
                                      _AboutController.dispose();
                                      _NameController.dispose();
                                      _TitleController.dispose();

                                      super.dispose();
                                    }
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Error Occured: User Not Found",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                }
                              } catch (e) {
                                Fluttertoast.showToast(
                                    msg: "Error Occured: Please Try Again",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Please Upload Image and Resume First")));
                            }
                          },
                          child: Text("Add Profile"),
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

final ButtonStyle kOutlineButtonStyle = OutlinedButton.styleFrom(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  side: const BorderSide(color: Colors.black),
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
);
