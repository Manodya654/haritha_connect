import 'package:flutter/material.dart';
import 'package:haritha_connect/job_details.dart';
import 'package:haritha_connect/saved.dart';
import 'Components.dart';

void main() {
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

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Job Added Successfully!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JobDetailsPage()), 
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Saved()), 
              );
            },
          ),
        ],
      ),
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
                        decoration: const InputDecoration(
                          labelText: "Job Position",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Please enter Job Position" : null,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
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
                        decoration: const InputDecoration(
                          labelText: "Salary",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Please enter Salary" : null,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: "Location",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? "Please enter  location" : null,
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