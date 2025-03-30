import 'package:flutter/material.dart';
import 'package:haritha_connect/components/Components.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EditProfileScreen(),
    ),
  );
}

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile Edited Successfully!")),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Edit Profile",
                      style: Kheaderstyle,
                    ),
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
                        decoration: const InputDecoration(
                          labelText: "Title",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "About",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Add Experience",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Skills Section
                      Text(
                        "Skills",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                                  print("HTML clicked");
                                },
                                style: kOutlineButtonStyle,
                                child: Text("HTML"),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  print("PHP Clicked");
                                },
                                style: kOutlineButtonStyle,
                                child: Text("PHP"),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  print("Java clicked");
                                },
                                style: kOutlineButtonStyle,
                                child: Text("Java"),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  print("C clicked");
                                },
                                style: kOutlineButtonStyle,
                                child: Text("C"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Wrap(
                            spacing: 20,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  print("React clicked");
                                },
                                style: kOutlineButtonStyle,
                                child: Text("React"),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  print("Dart clicked");
                                },
                                style: kOutlineButtonStyle,
                                child: Text("Dart"),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  print("Python clicked");
                                },
                                style: kOutlineButtonStyle,
                                child: Text("Python"),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  print("AI clicked");
                                },
                                style: kOutlineButtonStyle,
                                child: Text("Ai"),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Wrap(
                            spacing: 20,
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  print("C# clicked");
                                },
                                style: kOutlineButtonStyle,
                                child: Text("C#"),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  print("Javascript clicked");
                                },
                                style: kOutlineButtonStyle,
                                child: Text("Javascript"),
                              ),
                              OutlinedButton(
                                onPressed: () {
                                  print("Ruby clicked");
                                },
                                style: kOutlineButtonStyle,
                                child: Text("Ruby"),
                              )
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          child: Text("Edit Profile"),
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