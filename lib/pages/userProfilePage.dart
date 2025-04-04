import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_connect/components/curvedBackground.dart';
import 'package:ui_connect/components/BottomNavBar.dart';
import 'package:ui_connect/pages/Editprofile.dart';
import 'package:ui_connect/pages/login.dart';

class Userprofilepage extends StatefulWidget {
  final Map<String, dynamic> userMap;

  const Userprofilepage({super.key, required this.userMap});

  @override
  State<Userprofilepage> createState() => _UserprofilepageState();
}

class _UserprofilepageState extends State<Userprofilepage> {
  Map<String, dynamic>? profileData;

  void initState() {
    super.initState();
    fetchProfileDetails(); // Call the function to initialize profileData
  }

  Future<void> fetchProfileDetails() async {
    setState(() {
      profileData = widget.userMap;
    });
  }

  // Function to open Outlook or fall back to other email clients
  void openOutlookEmail(String email) async {
    // First, try to open Outlook using its custom URI scheme.
    final Uri outlookUri = Uri.parse("outlook://compose?to=$email");

    // Fallback to the standard mailto scheme if Outlook isn't available
    final Uri fallbackUri = Uri.parse("mailto:$email");

    try {
      // Try to open Outlook first
      if (await canLaunchUrl(outlookUri)) {
        await launchUrl(outlookUri, mode: LaunchMode.externalApplication);
      }
      // Fallback if Outlook isn't installed or doesn't work
      else if (await canLaunchUrl(fallbackUri)) {
        await launchUrl(fallbackUri, mode: LaunchMode.externalApplication);
      } else {
        print("Could not open email client");
      }
    } catch (e) {
      print("Error opening email client: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: profileData == null
          ? Center(
              child: CircularProgressIndicator()) // Show a loading indicator
          : LayoutBuilder(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Icon(Icons.arrow_back),
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5,
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
                                      padding: const EdgeInsets.only(
                                          left: 140, right: 10),
                                    ),
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
                                      color: Colors.white,
                                      width: 7), // White border
                                ),
                                child: CircleAvatar(
                                  radius: 65, // Adjust size
                                  backgroundImage: profileData != null &&
                                          profileData!['profilePic'] != null
                                      ? FileImage(
                                          File(profileData!['profilePic']))
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
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 35),
                          ),
                        ),
                        Center(
                          child: Text(
                            profileData!['Title'] ?? 'Software Engineering',
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
                                    padding: const EdgeInsets.only(
                                        left: 30, right: 30),
                                    child: Text(
                                      profileData!['About'] ??
                                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content:
                                                Text("No resume file found!")),
                                      );
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,
                                        ),
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 70, vertical: 12),
                                          decoration: BoxDecoration(
                                            color: Colors.blue[800],
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start, // Space between text and icon
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
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  SizedBox(height: 4),
                                                  Text(
                                                    '${profileData!['Name']}.pdf' ??
                                                        'AccountName.pdf',
                                                    style: TextStyle(
                                                      color: Colors.white70,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          if (profileData!['email'] != null) {
                                            openOutlookEmail(profileData![
                                                'email']); // Attempt to open Outlook first
                                          } else {
                                            print('No email available');
                                          }
                                        },
                                        icon: Icon(
                                          Icons.mail,
                                          color: Colors.blue[800],
                                          size: 30,
                                          weight: 5,
                                        ),
                                      )
                                    ],
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
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
                                              profileData!['Skills'].length,
                                              (index) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                child: ElevatedButton(
                                                  onPressed: () {},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.grey[200],
                                                    foregroundColor:
                                                        Colors.black,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                  child: Text(
                                                      profileData!['Skills']
                                                          [index]),
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
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                    0.1), // Shadow color
                                                blurRadius:
                                                    10, // Shadow blur radius
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
                                                padding: const EdgeInsets.only(
                                                    left: 10),
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
                                                          color:
                                                              Colors.grey[600]),
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
                                                          Icons
                                                              .access_time_filled,
                                                          color:
                                                              Colors.blue[800],
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
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(children: [
                                                      Icon(
                                                        Icons
                                                            .location_on_rounded,
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
                                                                FontWeight
                                                                    .bold),
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
        pageIndex: 2,
      ),
    );
  }
}
