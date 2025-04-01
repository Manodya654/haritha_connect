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
  // String? userType; // Store user type

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
        title: SearchBar(),
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

                    var courses = snapshot.data!.docs;

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
                              coursePic: courseData['coursePic'] ?? 'null',
                              name: courseData['name'] ?? 'Untitled',
                              description: courseData['description'] ??
                                  'No description available',
                              duration: courseData['duration'] ?? 'N/A',
                              subject: courseData['subject'] ?? 'Unknown',
                            ));
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
            decoration: InputDecoration(
              hintText: "Search job here...",
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

// class CourseCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
//             child: Image.network(
//               'https://img.freepik.com/free-vector/online-tutorials-concept_52683-37480.jpg?ga=GA1.1.1735124578.1741663265&semt=ais_keywords_boost',
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Android Development Essential Training: 1 Your First App",
//                   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   "This course teaches the basics of Android app development with Java and Kotlin...",
//                   style: TextStyle(color: Colors.grey[700]),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 SizedBox(height: 10),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Row(
//                       children: [
//                         Icon(Icons.people, size: 16),
//                         SizedBox(width: 5),
//                         Text("4.5K"),
//                       ],
//                     ),
//                     ElevatedButton(
//                       onPressed: () {},
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color.fromARGB(
//                           255,
//                           221,
//                           230,
//                           238,
//                         ), // FIXED: Updated primary color
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                       ),
//                       child: Text("Data Science"),
//                     ),
//                     Row(
//                       children: [
//                         Icon(Icons.access_time, size: 16),
//                         SizedBox(width: 5),
//                         Text("15 hr"),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
