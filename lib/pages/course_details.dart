import 'package:flutter/material.dart';
import 'package:ui_connect/pages/courses.dart';
import 'package:ui_connect/components/join_button.dart';

import 'dart:io';
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class CourseDetailsPage extends StatefulWidget {
  final String courseId;

  const CourseDetailsPage({required this.courseId});

  @override
  State<CourseDetailsPage> createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  Map<String, dynamic>? courseData; // Store fetched data
  @override
  void initState() {
    super.initState();
    fetchCourseDetails(widget.courseId);
  }

  Future<void> fetchCourseDetails(courseId) async {
    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('course')
          .doc(courseId)
          .get();

      if (doc.exists) {
        setState(() {
          courseData = doc.data() as Map<String, dynamic>;
        });
        print("Fetched Course Data: $courseData"); // Debugging
      } else {
        print("Course not found!");
      }
    } catch (e) {
      print("Error fetching course: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Courses()),
            );
          },
        ),
      ),
      body: courseData == null
          ? Center(
              child: CircularProgressIndicator(),
            ) // Show loader until data loads
          : Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    courseData!['name'] ?? 'No Title',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 25),
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: courseData!['coursePic'] != null
                            ? FileImage(File(courseData![
                                'coursePic'])) // Use FileImage for local file
                            : AssetImage('assets/images/course1.jpg')
                                as ImageProvider, // Asset as fallback

                        // image: AssetImage('assets/images/course1.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Course details',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 16,
                            backgroundImage:
                                AssetImage('assets/images/profile.jpg'),
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                courseData!['taughtBy'] ?? 'John Doe',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(137, 0, 0, 0),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Engineering Leader and Author',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        courseData!['addedDate'] != null
                            ? DateFormat('dd/MM/yyyy').format(
                                (courseData!['addedDate'] as Timestamp)
                                    .toDate())
                            : '24/6/25',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    courseData!['description'] ?? 'No description available',
                    style: TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  SizedBox(height: 16),
                  SizedBox(height: 4),
                  Text('Skills covered',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 10.0,
                    children: [
                      Chip(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        label: Text(courseData!['subject'] ?? 'ICT Skill',
                            style:
                                TextStyle(fontSize: 12, color: Colors.purple)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      JoinButton(
                          joinButtonText: "Join",
                          joinLink: courseData!['joinLink'] ?? ''),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
