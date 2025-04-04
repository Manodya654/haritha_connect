import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui_connect/components/BottomNavBar.dart';
import 'package:ui_connect/pages/userProfilePage.dart';

// Curved Background Widget
class CurvedBackground extends StatelessWidget {
  final double height;
  final Widget? child;

  const CurvedBackground({
    Key? key,
    this.height = 200, // Default height
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: CustomCurveClipper(),
          child: Container(
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade700, Colors.green.shade400],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
        ),
        if (child != null) Positioned.fill(child: child!),
      ],
    );
  }
}

class CustomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
      size.width / 2,
      size.height + 20,
      size.width,
      size.height - 50,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Header Text Style
const TextStyle Kheaderstyle = TextStyle(
  color: Colors.white,
  fontSize: 30,
  fontWeight: FontWeight.bold,
);

// User Search Screen
class UserSearchScreen extends StatefulWidget {
  @override
  _UserSearchScreenState createState() => _UserSearchScreenState();
}

class _UserSearchScreenState extends State<UserSearchScreen> {
  String searchQuery = "";
  final TextEditingController _searchController = TextEditingController();
  Set<String> seenNames = {}; // Prevents duplicate names

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Curved Background with Search Bar & Title inside it
          Stack(
            children: [
              CurvedBackground(height: 250),
              Positioned(
                top: 60, // Adjust vertical position
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title: "Search Users"
                    Text("Search Users", style: Kheaderstyle),
                    SizedBox(height: 15),

                    // Search Bar
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: "Search by name...",
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.blueAccent,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(Icons.clear, color: Colors.blueAccent),
                          onPressed: () {
                            setState(() {
                              searchQuery = "";
                              _searchController.clear();
                            });
                          },
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Search Results Section
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: StreamBuilder<QuerySnapshot>(
                stream: searchQuery.isEmpty
                    ? FirebaseFirestore.instance.collection("user").snapshots()
                    : FirebaseFirestore.instance
                        .collection("user")
                        .where("Name", isGreaterThanOrEqualTo: searchQuery)
                        .where("Name", isLessThan: searchQuery + 'z')
                        .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var users = snapshot.data!.docs;
                  seenNames.clear(); // Reset seen names

                  if (users.isEmpty) {
                    return Center(
                      child: Text(
                        "No users found",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      var user = users[index].data() as Map<String, dynamic>;

                      String userName = user["Name"] ?? "Unknown Name";
                      String userEmail = user["Title"] ?? "No Title Provided";

                      if (seenNames.contains(userName)) {
                        return SizedBox.shrink(); // Hide duplicates
                      }
                      seenNames.add(userName);

                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        shadowColor: Colors.grey[400],
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            child: Text(
                              userName.isNotEmpty
                                  ? userName[0].toUpperCase()
                                  : '',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          title: Text(
                            userName,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            userEmail,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 18,
                            color: Colors.blueAccent,
                          ),
                          onTap: () {
                            // Navigate to Profile Page and pass user data
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Userprofilepage(
                                  userMap: user,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Bottomnavbar(
        pageIndex: 2,
      ),
    );
  }
}
