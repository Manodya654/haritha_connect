import 'package:flutter/material.dart';
import 'package:haritha_connect/components/BottomNavBar.dart';
import 'package:haritha_connect/pages/job_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Jobs extends StatefulWidget {
  const Jobs({super.key});

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: TextField(
            decoration: InputDecoration(
              hintText: 'Search Job Here...',
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              fillColor: Colors.grey[200],
              filled: true,
            ),
          ),
          actions: [
            CircleAvatar(
                backgroundImage: AssetImage('assets/images/image.jpeg')),
            SizedBox(width: 15),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('jobs').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No jobs available'));
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      // Get job data from Firestore
                      var jobData = snapshot.data!.docs[index].data()
                          as Map<String, dynamic>;

                      List<Color> colors = [
                        Colors.blue,
                        Colors.pink,
                        Colors.green,
                        Colors.red,
                        Colors.yellow,
                      ];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JobDetailsPage()),
                          );
                        },
                        child: Card(
                          margin:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                        backgroundColor:
                                            colors[index % colors.length],
                                        radius: 20,
                                        backgroundImage:
                                            jobData['companyLogo'] != null &&
                                                    jobData['companyLogo']
                                                        .toString()
                                                        .isNotEmpty
                                                ? NetworkImage(
                                                    jobData['companyLogo'])
                                                : null),
                                    SizedBox(width: 8),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              jobData['jobPosition'] ??
                                                  'Unknown Position',
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(width: 30),
                                            Text(
                                              jobData['salary'] ??
                                                  'Salary not specified',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey[700]),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Wrap(
                                  spacing: 6,
                                  children: [
                                    Chip(
                                        label: Text(
                                            jobData['jobType'] ?? 'Full-Time'),
                                        backgroundColor: Colors.white),
                                    Chip(
                                        label: Text('Hybrid'),
                                        backgroundColor: Colors.grey[100]),
                                    Chip(
                                        label: Text(
                                            jobData['location'] ?? 'Unknown'),
                                        backgroundColor: Colors.white),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  jobData['jobDescription'] ??
                                      'No description available',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey[700]),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
        bottomNavigationBar: Bottomnavbar(
          pageIndex: 0,
        ));
  }
}
