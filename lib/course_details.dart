import 'package:flutter/material.dart';
import 'package:haritha_connect/courses.dart';
import 'package:haritha_connect/jobs.dart';
import 'package:haritha_connect/main4.dart';
import 'package:haritha_connect/profile.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    //home: MainPage(),
  ));
}

class CourseDetailsPage extends StatefulWidget {
  @override
  _CourseDetailsPageState createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  int _selectedIndex = 2; 

  final List<Widget> _pages = [
    HomeScreen(),
    Jobs(),
    Courses(),
    Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ['Home', 'Jobs', 'Courses', 'Profile'][_selectedIndex],
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Jobs'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Courses'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
    );
  }
}

class CourseDetailsView extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Details',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              ' Android Development Essential Training',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 25),
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage('images/course1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('Course details', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, 
              children: [
                Row( 
                  children: [
                    CircleAvatar(
                      radius: 16,  
                      backgroundImage: AssetImage('images/profile.jpg'), 
                    ),
                    SizedBox(width: 8),  
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Annyce Davis', 
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
                  '24/6/25', 
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
              'Android is the most popular mobile operating system in the world, holding 85% of global market share. That makes Android the natural starting point for new app developers. This series of courses teaches the basics needed to develop, design, manage, and distribute a native Android application using the Kotlin programming language and the Android SDK...',
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            SizedBox(height: 16),
            
            SizedBox(height: 4),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: [
            //         CircleAvatar(
            //           radius: 16,  
            //           backgroundImage: AssetImage('images/profile.jpg'), 
            //         ),
            //         Text('Annyce Davis', style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.bold)),
            //       ],
            //     ),
            //     //Text('By John Watson', style: TextStyle(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.bold)),
            //     Text('24/6/25', style: TextStyle(fontSize: 12, color: Colors.black54,fontWeight: FontWeight.bold)),
            //   ],
            // ),
            
            Text('Skills covered', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Wrap(
              spacing: 10.0,
              children: [
                Chip(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  label: Text('Android Development', style: TextStyle(fontSize: 12, color: Colors.purple)),
                ),
                Chip(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  label: Text('Mobile App Development', style: TextStyle(fontSize: 12, color: Colors.purple)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
