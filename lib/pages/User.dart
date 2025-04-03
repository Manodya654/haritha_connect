import 'package:flutter/material.dart';
import 'package:haritha_connect/components/BottomNavBar.dart';
import 'package:haritha_connect/pages/event_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  // Added missing function
  Stream<QuerySnapshot> getEventsWorkshop() {
    return FirebaseFirestore.instance
        .collection('events')
        .where('EventType', isEqualTo: 'Workshop')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search User Here...',
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
      body: Center(
        child: FeaturedEventCard(
          title: "User Name",
          organizer: "Title",
          about: "about",
          profileImage: 'assets/images/profile.jpeg',
        ),
      ),
    );
  }
}


class FeaturedEventCard extends StatelessWidget {
  final String title;
  final String organizer;
  final String about;
  final String profileImage;

  FeaturedEventCard({
    required this.title,
    required this.organizer,
    required this.about,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Featured Event",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Container(
            width: 300,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue, // Background color
              borderRadius: BorderRadius.circular(16), // Rounded corners
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left side with text content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // White text color
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        organizer,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70, // Slightly faded white
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        about,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white70, // Slightly faded white
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10), // Space between text and image
                // Right-side profile picture
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(profileImage),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}