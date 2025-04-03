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
        
      ),
      );
    }
  }