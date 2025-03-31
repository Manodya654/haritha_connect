import 'package:flutter/material.dart';
import 'package:haritha_connect/components/Components.dart';
import 'package:random_string/random_string.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../service/Database.dart';



class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController  _TitleController = TextEditingController();
  TextEditingController _NameController = TextEditingController();
  TextEditingController _AboutController = TextEditingController();
  TextEditingController _addExperienceController = TextEditingController();

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

  final ButtonStyle kOutlineButtonStyle = OutlinedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    side: const BorderSide(color: Colors.black),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  );

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
                      // Padding(
                      // padding: EdgeInsets.only(left: 20.0),
                      // child: IconButton(
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                      ),
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
                      TextFormField(
                        controller: _addExperienceController,
                        decoration: const InputDecoration(
                          labelText: "Add Experience",
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
                              backgroundColor: isSelected ? Colors.blue : Colors.white,
                              foregroundColor: isSelected ? Colors.white : Colors.black,
                            ),
                            child: Text(skill),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async{
                            String id = randomAlphaNumeric(10);
                            Map<String,dynamic> addprofileMap = {

                              "id": id,
                              "Title": _TitleController.text,
                              "Name": _NameController.text,
                              "About": _AboutController.text,
                              "Experience": _addExperienceController.text,
                              "Skills": selectedSkills,

                            };

                            await  DatabaseMethods().addProfile(addprofileMap,id).then((value) {
                              Fluttertoast.showToast(
                                  msg: "Profile Edited Successfully",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );});



                          },
                          child: Text("Edit"),
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
