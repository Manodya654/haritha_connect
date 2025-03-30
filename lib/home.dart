import 'package:flutter/material.dart';
import 'package:haritha_connect/componets/BottomNavBar.dart';
import 'package:haritha_connect/courses.dart';
import 'package:haritha_connect/events.dart';
import 'package:haritha_connect/job_details.dart';
import 'package:haritha_connect/profile.dart';
import 'package:haritha_connect/componets/NavigationDrawer.dart';
import 'package:haritha_connect/componets/header.dart';
import 'package:haritha_connect/componets/NavigationDrawer.dart' as custom;

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const custom.NavigationDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            HeaderWidget(scaffoldKey: _scaffoldKey),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  List<String> logos = List.generate(5, (_) => 'images/company1.jpg');
                  List<String> jobTitles = [
                    'Web Developer',
                    'Software Engineer Intern',
                    'Data Analyst',
                    'UI/UX Designer',
                    'Project Manager',
                  ];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JobDetailsPage(),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(logos[index]),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        jobTitles[index],
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        '250k - 315k USD/year',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            
                            Wrap(
                              spacing: 6,
                              children: [
                                Chip(label: const Text('Full-Time')),
                                Chip(label: const Text('Hybrid')),
                                Chip(label: const Text('Colombo')),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'At Vilampara Media, we are leading digital marketing through our innovative Power Reach AI ecosystem, designed to help businesses expand their reach and grow efficiently...',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[700],
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
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
