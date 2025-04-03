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
  Stream<QuerySnapshot> getUsers() {
    return FirebaseFirestore.instance.collection('Profile').snapshots();
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
      body: StreamBuilder<QuerySnapshot>(
        stream: getUsers(),
    builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return Center(child: CircularProgressIndicator());
    }
    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
    return Center(child: Text("No users found"));
    }

    var users = snapshot.data!.docs;

    return ListView.builder(
    itemCount: users.length,
    itemBuilder: (context, index) {
    var user = users[index];
    return FeaturedEventCard(
    title: user['Name'], // Ensure field names match Firestore
    organizer: user['title'],
    about: user['about'],
    profileImage: user['profileImage'], // Should be a valid URL or asset path
    );
    },
    );
    },
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
          SizedBox(height: 8),
          Container(
            width: 350,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue, // Background color
              borderRadius: BorderRadius.circular(16), // Rounded corners
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center, // Center items vertically
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
                // Right-side profile picture - now will be centered vertically
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