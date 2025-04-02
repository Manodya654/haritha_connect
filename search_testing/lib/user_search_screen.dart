import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      appBar: AppBar(title: Text("Search Users")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search by name...",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      searchQuery = "";
                      _searchController.clear();
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),

          // Search Results - Only Show If User Typed Something
          if (searchQuery.isNotEmpty)
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .where("name", isGreaterThanOrEqualTo: searchQuery)
                    .where("name", isLessThan: searchQuery + 'z')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var users = snapshot.data!.docs;

                  if (users.isEmpty) {
                    return Center(child: Text("No users found"));
                  }

                  seenNames.clear(); // Reset seen names before listing users

                  return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      var user = users[index].data() as Map<String, dynamic>;

                      // Prevent duplicate names from appearing twice
                      if (seenNames.contains(user["name"])) {
                        return SizedBox.shrink(); // Hide duplicates
                      }
                      seenNames.add(user["name"]);

                      return ListTile(
                        title: Text(user["name"]),
                        subtitle: Text(user["email"]),
                      );
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
