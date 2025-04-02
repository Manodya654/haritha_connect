import 'package:flutter/material.dart';
import 'dart:io';

class CourseCard extends StatelessWidget {
  final String courseId;
  final String coursePic;
  final String name;
  final String description;
  final String duration;
  final String subject;
  final String userType;

  CourseCard({
    required this.courseId,
    required this.coursePic,
    required this.name,
    required this.description,
    required this.duration,
    required this.subject,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.file(
              File(coursePic),
              fit: BoxFit.contain,
              width: double.infinity,
              height: 200,
              errorBuilder: (context, error, stackTrace) =>
                  Icon(Icons.broken_image, size: 100),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    if (userType == "staff")
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => AddCourseScreen(
                              //               courseId: courseId,
                              //             )),
                              //   );
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.delete,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      )
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey[700]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.people, size: 16),
                        SizedBox(width: 5),
                        Text("4.5K"),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 221, 230, 238),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text(subject),
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16),
                        SizedBox(width: 5),
                        Text(duration),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
