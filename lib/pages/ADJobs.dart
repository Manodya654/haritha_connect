import 'package:flutter/material.dart';
import 'package:ui_connect/components/Components.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddJobScreen extends StatefulWidget {
  final String? jobId;
  final Map<String, dynamic>? jobData;

  AddJobScreen({this.jobId, this.jobData});

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

  @override
  void dispose() {
    _companyNameController.dispose();
    _companyLogoController.dispose();
    _jobPositionController.dispose();
    _jobDescriptionController.dispose();
    _salaryController.dispose();
    _locationController.dispose();
    _applyLinkController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> jobData = {
        'companyName': _companyNameController.text,
        'companyLogo': _companyLogoController.text,
        'jobPosition': _jobPositionController.text,
        'jobDescription': _jobDescriptionController.text,
        'salary': _salaryController.text,
        'location': _locationController.text,
        'jobType': _jobType,
        'applyLink': _applyLinkController.text,
        'postedTime': DateTime.now().toString(),
      };

      try {
        if (widget.jobId != null) {
          await FirebaseFirestore.instance
              .collection('jobs')
              .doc(widget.jobId)
              .update(jobData);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Job Updated Successfully!")));
        } else {
          await FirebaseFirestore.instance.collection('jobs').add(jobData);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Job Added Successfully!")));
        }

        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error: $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Curved Background with Back Button and Title
          Positioned.fill(
            child: CurvedBackground(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Row(
                      children: [
                        // Back Button
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        SizedBox(width: 10),
                        Text("Job Details", style: Kheaderstyle),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Job Form Content
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
                      _buildTextField(_companyNameController, "Company Name"),
                      const SizedBox(height: 20),
                      _buildTextField(_companyLogoController, "Company Logo"),
                      const SizedBox(height: 20),
                      _buildTextField(_jobPositionController, "Job Position"),
                      const SizedBox(height: 30),
                      _buildTextField(
                          _jobDescriptionController, "Job Description"),
                      const SizedBox(height: 30),
                      _buildTextField(_salaryController, "Salary"),
                      const SizedBox(height: 30),
                      _buildTextField(_locationController, "Location"),
                      const SizedBox(height: 30),
                      _buildTextField(_applyLinkController, "Apply Link"),
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
                      _buildJobTypeButtons(),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          child: Text("Create"),
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

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
      validator: (value) => value!.isEmpty ? "Please enter $label" : null,
    );
  }

  Widget _buildJobTypeButtons() {
    final jobTypes = ["Full Time", "Remote working", "Hourly"];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: jobTypes.map((type) {
          return Padding(
            padding: const EdgeInsets.only(right: 15),
            child: OutlinedButton(
              onPressed: () {
                setState(() {
                  _jobType = type;
                });
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                side: BorderSide(
                  color: _jobType == type ? Colors.blue : Colors.black,
                ),
                backgroundColor:
                    _jobType == type ? Colors.blue.withOpacity(0.2) : null,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: Text(
                type,
                style: TextStyle(
                  color: _jobType == type ? Colors.blue : Colors.black,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
