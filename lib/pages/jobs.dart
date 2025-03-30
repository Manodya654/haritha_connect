import 'package:flutter/material.dart';
import 'package:ui_connect/components/BottomNavBar.dart';

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        'Jobs',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(width: 100),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 28, 104, 166),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Text(
                        'Events',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  List<Color> colors = [
                    Colors.blue,
                    Colors.pink,
                    Colors.green,
                    Colors.red,
                    Colors.yellow,
                  ];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
                                  backgroundColor: colors[index], radius: 20),
                              SizedBox(width: 8),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        index == 0
                                            ? 'Web Developer'
                                            : 'Software Engineer',
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(width: index == 0 ? 50 : 30),
                                      Text(
                                        '250k - 315k USD/year',
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
                                  label: Text('Full-Time'),
                                  backgroundColor: Colors.white),
                              Chip(
                                  label: Text('Hybrid'),
                                  backgroundColor: Colors.grey[100]),
                              Chip(
                                  label: Text('Colombo'),
                                  backgroundColor: Colors.white),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            'At Vilampara Media, we are leading digital marketing through our innovative Power Reach AI ecosystem, designed to help businesses expand their reach and grow efficiently. As part of this initiative, we are seeking a creative and technically skilled Web Designer to join our team. This role is essential in building, managing, and optimizing WordPress websites that form the foundation of our clients’ digital success.',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey[700]),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
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
