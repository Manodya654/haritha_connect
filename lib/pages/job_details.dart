import 'package:flutter/material.dart';
import 'package:haritha_connect/pages/jobs.dart';

class JobDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Jobs()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.bookmark_border),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Jobs()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Virtusa Pvt. Ltd.',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Senior Software Engineer',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(width: 70),
                CircleAvatar(
                  radius: 32,
                  backgroundImage: AssetImage('assets/images/company1.jpg'),
                ),
              ],
            ),
            SizedBox(height: 15),
            Wrap(
              spacing: 10.0,
              children: [
                Chip(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label:
                      Text('Fulltime', style: TextStyle(color: Colors.purple)),
                  //backgroundColor: Colors.grey[300],
                ),
                Chip(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: Text('Remote Working',
                      style: TextStyle(color: Colors.purple)),
                  //backgroundColor: Colors.grey[300],
                ),
                Chip(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  label: Text('Hourly', style: TextStyle(color: Colors.purple)),
                  //backgroundColor: Colors.grey[300],
                ),
              ],
            ),
            SizedBox(height: 28),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 207, 254),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.attach_money,
                          color: Color.fromARGB(255, 90, 20, 99), size: 18),
                    ),
                    SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Salary',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          '\$500 - \$1,000/monthly',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 207, 254),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.location_on,
                          color: Color.fromARGB(255, 90, 20, 99), size: 18),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Location',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        Text(
                          'Medan, Indonesia',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 25),
            Text(
              'About this Job',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Virtusa is a billion-dollar revenue company with 7000+ employees on all continents. Our leading AI technology is the backbone of our award-winning enterprise software solutions, enabling our customers to be their best when it really matters–at the Moment of Service™. Our commitment to internal AI adoption has allowed us to stay at the forefront of technological advancements, ensuring our colleagues can unlock their creativity and productivity, and our solutions are always cutting-edge.',
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Text(
              'Qualifications',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.check_circle,
                        color: Color.fromARGB(255, 3, 14, 115), size: 18),
                    title: Text(
                        'Basic understanding of programming languages (e.g., Java, Python, C++).',
                        style: TextStyle(fontSize: 14)),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.check_circle,
                        color: Color.fromARGB(255, 3, 14, 115), size: 18),
                    title: Text(
                        'Strong problem-solving skills and attention to detail.',
                        style: TextStyle(fontSize: 14)),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.check_circle,
                        color: Color.fromARGB(255, 3, 14, 115), size: 18),
                    title: Text('Good communication and teamwork abilities.',
                        style: TextStyle(fontSize: 14)),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(Icons.check_circle,
                        color: Color.fromARGB(255, 3, 14, 115), size: 18),
                    title: Text(
                        'Familiarity with software development methodologies and best practices.',
                        style: TextStyle(fontSize: 14)),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                width: 120,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 3, 14, 115),
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'Apply Job',
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
