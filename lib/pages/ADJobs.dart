import 'package:flutter/material.dart';
import 'package:haritha_connect/components/Components.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:haritha_connect/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AddJobScreen(),
    ),
  );
}

class AddJobScreen extends StatefulWidget {
  @override
  _AddJobScreenState createState() => _AddJobScreenState();
}

class _AddJobScreenState extends State<AddJobScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _companyNameController = TextEditingController();
  final TextEditingController _companyLogoController = TextEditingController();
  final TextEditingController _jobPositionController = TextEditingController();
  final TextEditingController _jobDescriptionController =
      TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _applyLinkController = TextEditingController();

  String _jobType = '';
  String? userType;

  @override
  void initState() {
    super.initState();
    fetchUserType();
  }

  Future<void> fetchUserType() async {
    String? type = await getUserType();
    setState(() {
      userType = type;
    });
  }

  Future<String?> getUserType() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .get();

        if (userDoc.exists && userDoc.data() != null) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;
          if (userData.containsKey('type')) {
            return userData['type'];
          }
        }
      }
    } catch (e) {
      print('Error fetching user type: $e');
    }
    return null;
  }

  @override
  void dispose() {
    _jobPositionController.dispose();
    _jobDescriptionController.dispose();
    _salaryController.dispose();
    _locationController.dispose();
    _applyLinkController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      String timestamp = DateTime.now().toString();
      // Create a map of data to send to Firestore
      Map<String, dynamic> jobData = {
        'companyName': _companyNameController.text,
        'companyLogo': _companyLogoController.text,
        'jobPosition': _jobPositionController.text,
        'jobDescription': _jobDescriptionController.text,
        'salary': _salaryController.text,
        'location': _locationController.text,
        'jobType': _jobType,
        'applyLink': _applyLinkController.text,
        'postedTime': timestamp,
      };

      try {
        // Add the jobData to the "jobs" collection
        await FirebaseFirestore.instance.collection('jobs').add(jobData);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Job Added Successfully!")),
        );

        // Optionally clear the form after successful submission
        _companyNameController.clear();
        _companyLogoController.clear();
        _jobPositionController.clear();
        _jobDescriptionController.clear();
        _salaryController.clear();
        _locationController.clear();
        _applyLinkController.clear();
        setState(() {
          _jobType = '';
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error adding job: $e")),
        );
      }
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
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Job Details",
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
            bottom: 20, // Ensure it expands properly
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
                        controller: _companyNameController,
                        decoration: const InputDecoration(
                          labelText: "Company Name",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Please enter Company Name" : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _companyLogoController,
                        decoration: const InputDecoration(
                          labelText: "Company Logo",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value!.isEmpty
                            ? "Please enter Company Logo URL"
                            : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _jobPositionController,
                        decoration: const InputDecoration(
                          labelText: "Job Position",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Please enter Job Position" : null,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _jobDescriptionController,
                        decoration: const InputDecoration(
                          labelText: "Job Description",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value!.isEmpty
                            ? "Please enter Job Description"
                            : null,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _salaryController,
                        decoration: const InputDecoration(
                          labelText: "Salary",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Please enter Salary" : null,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _locationController,
                        decoration: const InputDecoration(
                          labelText: "Location",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Please enter  location" : null,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _applyLinkController,
                        decoration: const InputDecoration(
                          labelText: "Apply Link",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Enter the link" : null,
                      ),
                      const SizedBox(height: 30),

                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: Text(
                          "Job Type",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _jobType = "Full Time";
                                });
                                print("Full Time clicked");
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                side: BorderSide(color: Colors.black),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                "Full Time",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            SizedBox(width: 20),
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _jobType = "Remote working";
                                });
                                print("Remote working clicked");
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                side: BorderSide(color: Colors.black),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                "Remote working",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            SizedBox(width: 20),
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  _jobType = "Hourly";
                                });
                                print("Hourly working clicked");
                              },
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                side: BorderSide(color: Colors.black),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text(
                                "Hourly ",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          child: Text("Create"),
                        ),
                      ),

                      const SizedBox(height: 50), // Extra spacing at the bottom
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
