import 'package:flutter/material.dart';
import 'package:haritha_connect/componets/BottomNavBar.dart';
import 'package:haritha_connect/componets/NavigationDrawer.dart' as custom;
import 'package:haritha_connect/componets/header.dart';
import 'package:haritha_connect/course_details.dart';

class Courses extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const custom.NavigationDrawer(), // Custom navigation drawer
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150), // Adjust height if needed
        child: HeaderWidget(scaffoldKey: _scaffoldKey), // Custom header
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
              'Courses',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  return CourseCard();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}

class CourseCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () { // FIXED: Changed `onPressed` to `onTap`
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CourseDetailsView()), 
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                'images/course1.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Android Development Essential Training: 1 Your First App",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "This course teaches the basics of Android app development with Java and Kotlin...",
                    style: TextStyle(color: Colors.grey[700]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.people, size: 16),
                          SizedBox(width: 5),
                          Text("4.5K"),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 221, 230, 238),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text("Data Science"),
                      ),
                      Row(
                        children: const [
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
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final Color color;

  const CategoryButton({Key? key, required this.label, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(label),
    );
  }
}
