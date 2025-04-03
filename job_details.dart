import 'package:flutter/material.dart';
import 'package:testing_senuris_one/pages/jobs.dart';

import 'package:url_launcher/url_launcher.dart';
import 'dart:io';

class JobDetailsPage extends StatelessWidget {
  final String jobId;
  final String companyName;
  final String applyLink;
  final String companyLogo;
  final String jobDescription;
  final String jobPosition;
  final String jobType;
  final String salary;
  final String location;

  const JobDetailsPage({
    super.key,
    required this.jobId,
    required this.companyName,
    required this.applyLink,
    required this.companyLogo,
    required this.jobDescription,
    required this.jobPosition,
    required this.jobType,
    required this.salary,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Job Details',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Jobs()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Jobs()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$companyName',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '$jobPosition',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 70),
                CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage('$companyLogo'),
                ),
              ],
            ),
            SizedBox(height: 15),
            Wrap(
              spacing: 10.0,
              children: [
                Chip(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: Text(
                    '$jobType',
                    style: TextStyle(color: Colors.purple),
                  ),
                  //backgroundColor: Colors.grey[300],
                ),
              ],
            ),
            SizedBox(height: 28),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 207, 254),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.attach_money,
                        color: Color.fromARGB(255, 90, 20, 99),
                        size: 18,
                      ),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Salary',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text('$salary', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 207, 254),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.location_on,
                        color: Color.fromARGB(255, 90, 20, 99),
                        size: 18,
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text('$location', style: TextStyle(fontSize: 14)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 25),
            Text(
              'About this Job',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '$jobDescription',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),

            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  JoinButton(
                    joinButtonText: "Apply Job",
                    joinLink: '$applyLink',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class JoinButton extends StatefulWidget {
  final String? joinLink;
  final String joinButtonText;
  const JoinButton({required this.joinButtonText, required this.joinLink});

  @override
  State<JoinButton> createState() => _JoinButtonState();
}

class _JoinButtonState extends State<JoinButton> {
  bool _linkLoading = false;

  Future<void> _launchURL() async {
    setState(() {
      _linkLoading = true; // Show CircularProgressIndicator
    });

    final Uri url = Uri.parse(widget.joinLink ?? "");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to open link!'),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() {
      _linkLoading = false; // Restore button text after loading
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
          _linkLoading ? null : _launchURL, // Disable button when loading
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      child:
          _linkLoading
              ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
              : Text(widget.joinButtonText, style: TextStyle(fontSize: 16)),
    );
  }
}
