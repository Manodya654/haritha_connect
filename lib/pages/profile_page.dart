import 'dart:io';
import 'package:open_file/open_file.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_connect/components/curvedBackground.dart';
import 'package:ui_connect/components/BottomNavBar.dart';
import 'package:ui_connect/pages/Editprofile.dart';
import 'package:ui_connect/pages/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic>? profileData; // Store fetched data

  @override
  void initState() {
    super.initState();
    fetchProfileDetails();
  }

  Future<void> fetchProfileDetails() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        String userId = user.uid;

        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection("user")
            .doc(userId)
            .get();

        if (userDoc.exists) {
          setState(() {
            profileData = userDoc.data() as Map<String, dynamic>;
          });

          print("Fetched Account Details Data: $profileData"); // Debugging
        } else {
          print("Account Details not found!");
        }
      }
    } catch (e) {
      print("Error Fetching Account Details: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              SizedBox(
                height: 250,
                child: Stack(
                  children: [
                    // Background with Fixed Header
                    CurvedBackground(
                      height: 220,
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 5,
                              ),
                              IconButton(
                                onPressed: () async {
                                  User? user =
                                      FirebaseAuth.instance.currentUser;
                                  if (user != null) {
                                    String userId = user.uid;
                                    try {
                                      await FirebaseFirestore.instance
                                          .collection("user")
                                          .doc(userId)
                                          .update({
                                        "isLoggedIn": false
                                      }); // Update the field to false

                                      await FirebaseAuth.instance
                                          .signOut(); // Sign out from Firebase

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()),
                                      );
                                    } catch (e) {
                                      print("Error logging out: $e");
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                "Error logging out. Please try again.")),
                                      );
                                    }
                                  }
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                  );
                                },
                                icon: const Icon(
                                  Icons.logout,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                  "Profile Page",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 140, right: 10),
                                child: IconButton(
                                  color: Colors.black,
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EditProfileScreen()),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Content below the CurvedBackground
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(1), // Border thickness
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: Colors.white, width: 7), // White border
                          ),
                          child: CircleAvatar(
                            radius: 65, // Adjust size
                            backgroundImage: profileData!['profilePic'] != null
                                ? FileImage(File(profileData!['profilePic']))
                                : NetworkImage(
                                    "https://img.freepik.com/free-photo/business-man-by-skyscraper_1303-13655.jpg?ga=GA1.1.1378088882.1742949859&semt=ais_hybrid"), // Local image
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      profileData!['Name'] ?? 'Henry Kanwil',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
                    ),
                  ),
                  Center(
                    child: Text(
                      profileData!['Title'] ?? 'Henry Kanwil',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    height: constraints.maxHeight - 400,
                    child: SingleChildScrollView(
                      // scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 30, right: 30),
                              child: Text(
                                profileData!['About'] ??
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          GestureDetector(
                            onTap: () async {
                              if (profileData!['resume'] != null) {
                                String filePath = profileData!['resume'];
                                OpenFile.open(filePath);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("No resume file found!")),
                                );
                              }
                            },
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: Colors.blue[800],
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween, // Space between text and icon
                                  children: [
                                    // Left side (Texts)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Resume',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          '${profileData!['Name']}.pdf' ??
                                              'AccountName.pdf',
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Text(
                                  "Skills",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis
                                  .horizontal, // Enables horizontal scrolling

                              child: Row(
                                children: profileData != null &&
                                        profileData!['Skills'] != null &&
                                        profileData!['Skills'] is List
                                    ? List.generate(
                                        profileData!['Skills'].length, (index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.grey[200],
                                              foregroundColor: Colors.black,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                            child: Text(
                                                profileData!['Skills'][index]),
                                          ),
                                        );
                                      })
                                    : [
                                        Text("No Skills Added")
                                      ], // Show this if skills are empty
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 25),
                                child: Text(
                                  "Experience",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 15),
                            child: Column(
                              children: List.generate(3, (index) {
                                // Example: 10 buttons
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical:
                                          8), // Adds spacing between buttons
                                  child: Container(
                                    height: 150,
                                    width: 350,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withOpacity(0.1), // Shadow color
                                          blurRadius: 10, // Shadow blur radius
                                          offset: Offset(0,
                                              4), // Shadow offset (downwards)
                                        ),
                                      ],
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Container(
                                            width: 100, // Image size
                                            height: 100, // Image size
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    'https://img.freepik.com/free-vector/illustration-photo-studio-stamp-banner_53876-6842.jpg?ga=GA1.1.1378088882.1742949859&semt=ais_hybrid'), // Replace with your image URL
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Column for multiple text elements on the right side of the image
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'High Speed Studio',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.grey[600]),
                                              ),
                                              SizedBox(height: 5),
                                              Text(
                                                'Junior Software Engineering',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 20),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.access_time_filled,
                                                    color: Colors.blue[800],
                                                    size: 30,
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                    '3 Years',
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Row(children: [
                                                Icon(
                                                  Icons.location_on_rounded,
                                                  color: Colors.blue[800],
                                                  size: 30,
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  'Katugastota, Kandy',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ]),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          );
        },
      ),
      bottomNavigationBar: Bottomnavbar(
        pageIndex: 4,
      ),
    );
  }
}
