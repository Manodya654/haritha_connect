import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui_connect/components/BottomNavBar.dart';
import 'package:ui_connect/pages/ADJobs.dart';
import 'package:ui_connect/pages/editJob.dart';
import 'package:ui_connect/pages/job_details.dart'; // Import your JobDetails page here

class Jobs extends StatefulWidget {
  const Jobs({super.key});

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _searchController =
      TextEditingController(); // Search controller
  String _searchQuery = ""; // Search query
  String? userType;

  // Method to delete a job from Firestore
  void _deleteJob(String jobId) async {
    try {
      await _firestore.collection('jobs').doc(jobId).delete();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Job deleted successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error deleting job: $e')));
    }
  }

  // Method to handle search input
  void _searchJob(String query) {
    setState(() {
      _searchQuery = query
          .toLowerCase(); // Convert to lowercase for case-insensitive search
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchUserType();
  }

  // Fetch userType and store it in state
  Future<void> _fetchUserType() async {
    String? type = await getUserType();
    if (mounted) {
      setState(() {
        userType = type;
      });
    }
  }

  Future<String?> getUserType() async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Reference to the user's document in Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('user')
            .doc(user.uid)
            .get();

        // Check if the document exists and contains the 'type' field
        if (userDoc.exists && userDoc.data() != null) {
          Map<String, dynamic> userData =
              userDoc.data() as Map<String, dynamic>;

          if (userData.containsKey('type')) {
            String userType = userData['type'];
            print('User Type: $userType');
            return userData['type'];
          } else {
            print('Type field not found in user document.');
          }
        } else {
          print('User document does not exist.');
        }
      } else {
        print('No user is signed in.');
      }
    } catch (e) {
      print('Error fetching user type: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(10)),
          _buildCategoryRow(),
          Expanded(child: _buildJobList()),
        ],
      ),
      bottomNavigationBar: Bottomnavbar(pageIndex: 0),
    );
  }

  // App Bar with Search Field and Profile Avatar
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: TextField(
        controller: _searchController, // Attach search controller here
        onChanged: _searchJob, // Call search method on text change
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
        CircleAvatar(backgroundImage: AssetImage('assets/images/image.jpeg')),
        SizedBox(width: 15),
      ],
    );
  }

  // Category Row with Add Job Button
  Widget _buildCategoryRow() {
    return FutureBuilder<String?>(
      future: getUserType(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        String? userType = snapshot.data;
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 15),
            CategoryButton(label: 'Jobs', color: Colors.white70),
            const SizedBox(width: 10),
            // Show the button only if userType is "staff"
            if (userType == "staff" || userType == "alumni")
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddJobScreen()),
                  );
                },
                icon: Icon(
                  Icons.add,
                  color: Colors.deepPurple,
                ),
              ),

            const SizedBox(width: 10),
          ],
        );
      },
    );
  }

  // Job List using Firestore Stream with search filter
  Widget _buildJobList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('jobs').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong!'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text('No jobs available.'));
        }

        final jobs = snapshot.data!.docs.where((job) {
          // Filter jobs based on search query (case-insensitive)
          String jobPosition = job['jobPosition']?.toLowerCase() ?? '';
          String companyName = job['companyName']?.toLowerCase() ?? '';
          return jobPosition.contains(_searchQuery) ||
              companyName.contains(_searchQuery);
        }).toList();

        return ListView.builder(
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            var job = jobs[index];

            return Dismissible(
              key: Key(job.id),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                _deleteJob(job.id);
              },
              child: JobCard(
                jobId: job.id,
                jobPosition: job['jobPosition'] ?? 'No Job Position',
                companyName: job['companyName'] ?? 'Unknown Company',
                salary: job['salary'] ?? 'No Salary Info',
                jobType: job['jobType'] ?? 'No Job Type',
                location: job['location'] ?? 'No Location',
                description: job['jobDescription'] ?? 'No Description',
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Editjob(jobId: job.id),
                    ),
                  );
                },
                onDelete: () => _deleteJob(job.id),
                onTap: () {
                  // Navigate to JobDetails page with all the required data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => JobDetailsPage(
                        jobId: job.id,
                        companyName: job['companyName'] ?? 'Unknown Company',
                        applyLink: job['applyLink'] ?? 'No Apply Link',
                        companyLogo:
                            job['companyLogo'] ?? 'https://defaultLogoURL.com',
                        jobDescription:
                            job['jobDescription'] ?? 'No Description',
                        jobPosition: job['jobPosition'] ?? 'No Job Position',
                        jobType: job['jobType'] ?? 'No Job Type',
                        salary: job['salary'] ?? 'No Salary',
                        location: job['location'] ?? 'No location',
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}

// Job Card Widget
class JobCard extends StatelessWidget {
  final String jobId;
  final String jobPosition;
  final String companyName;
  final String salary;
  final String jobType;
  final String location;
  final String description;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  JobCard({
    required this.jobPosition,
    required this.companyName,
    required this.salary,
    required this.jobType,
    required this.location,
    required this.description,
    required this.onEdit,
    required this.onDelete,
    required this.jobId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Trigger onTap method when the card is tapped
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobPosition,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        companyName,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.black),
                        onPressed: onEdit,
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.black),
                        onPressed: onDelete,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 6,
                children: [
                  Chip(label: Text(jobType), backgroundColor: Colors.white),
                  Chip(
                    label: Text(location),
                    backgroundColor: Colors.grey[100],
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Category Button Widget
class CategoryButton extends StatelessWidget {
  final String label;
  final Color color;

  CategoryButton({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(label),
    );
  }
}
