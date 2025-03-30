import 'package:flutter/material.dart';
import 'package:haritha_connect/components/Components.dart';
<<<<<<< Updated upstream
import 'package:ui_connect/pages/course_details.dart';
=======
import 'package:haritha_connect/components/BottomNavBar.dart';
>>>>>>> Stashed changes

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CategoryButton(label: 'Courses', color: Colors.white70),
                const SizedBox(width: 10),
              ],
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CourseDetailsPage()),
                        );
                      },
                      child: CourseCard());
                },
              ),
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
          ), // Profile image from a placeholder service
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

class CourseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            child: Image.network(
              'https://img.freepik.com/free-vector/online-tutorials-concept_52683-37480.jpg?ga=GA1.1.1735124578.1741663265&semt=ais_keywords_boost',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Android Development Essential Training: 1 Your First App",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "This course teaches the basics of Android app development with Java and Kotlin...",
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
                        backgroundColor: const Color.fromARGB(
                          255,
                          221,
                          230,
                          238,
                        ), // FIXED: Updated primary color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text("Data Science"),
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16),
                        SizedBox(width: 5),
                        Text("15 hr"),
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
