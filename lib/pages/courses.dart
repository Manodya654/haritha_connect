import 'package:flutter/material.dart';
import 'package:haritha_connect/components/BottomNavBar.dart';
import 'package:haritha_connect/pages/course_details.dart';


import 'package:ui_connect/pages/ADCourse.dart';
import 'package:ui_connect/components/course_card.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  String? userType;

  @override
  void initState() {
    super.initState();
    _fetchUserType();
  }

  // Fetch userType and store it in state
  Future<void> _fetchUserType() async {
    String? type = await getUserType();
    if (mounted) {
      setState(() {
        userType = type;
      });
    }
  }

  Future<String?> getUserType() async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Reference to the user's document in Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .get();

        // Check if the document exists and contains the 'type' field
        if (userDoc.exists && userDoc.data() != null) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;

          if (userData.containsKey('type')) {
            String userType = userData['type'];
            print('User Type: $userType');
            return userData['type'];
          } else {
            print('Type field not found in user document.');
          }
        } else {
          print('User document does not exist.');
        }
      } else {
        print('No user is signed in.');
      }
    } catch (e) {
      print('Error fetching user type: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: SearchBar(
          searchController: searchController,
          onChanged: (value) {
            setState(() {
              searchQuery = value.toLowerCase();
            });
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<String?>(
              future: getUserType(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                String? userType = snapshot.data;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CategoryButton(label: 'Courses', color: Colors.white70),
                    const SizedBox(width: 10),
                    // Show the button only if userType is "staff"
                    if (userType == "staff")
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddCourseScreen()),
                          );
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.deepPurple,
                        ),
                      ),

                    const SizedBox(width: 10),
                  ],
                );
              },
            ),
            SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('course')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return Center(child: Text("No courses available"));
                    }

                    var courses = snapshot.data!.docs.where((doc) {
                      var courseData = doc.data() as Map<String, dynamic>;
                      String courseName =
                          courseData['name']?.toString().toLowerCase() ?? "";

                      // If searchQuery is empty, return true (i.e., show all courses)
                      if (searchQuery.isEmpty) return true;

                      return courseName.contains(
                          searchQuery); // Only show courses that match the search
                    }).toList();

                    return ListView.builder(
                      itemCount: courses.length,
                      itemBuilder: (context, index) {
                        var courseDoc = courses[index];
                        var courseData =
                            courseDoc.data() as Map<String, dynamic>;
                        String courseId = courseDoc.id;
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CourseDetailsPage(
                                        courseId: courseId,
                                      )),
                            );
                          },
                          child: CourseCard(
                            courseId: courseId,
                            coursePic: courseData['coursePic'] ?? 'null',
                            name: courseData['name'] ?? 'Untitled',
                            description: courseData['description'] ??
                                'No description available',
                            duration: courseData['duration'] ?? 'N/A',
                            subject: courseData['subject'] ?? 'Unknown',
                            userType: userType ?? "",
                          ),
                        );
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Bottomnavbar(
        pageIndex: 2,
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onChanged;

  SearchBar({required this.searchController, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            'https://i.pravatar.cc/150?img=3',
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextField(
            controller: searchController,
            onChanged: onChanged,
            decoration: InputDecoration(
              hintText: "Search course here...",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ],
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final Color color;

  CategoryButton({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // FIXED: Updated primary color
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(label),
    );
  }
}
