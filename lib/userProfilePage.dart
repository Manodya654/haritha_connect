import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UserProfilePage extends StatelessWidget {
  final Map<String, dynamic> user;

  const UserProfilePage({Key? key, required this.user}) : super(key: key);

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
    // Extract user data
    final String userName = user['name'] ?? 'Unknown User';
    final String userTitle = user['title'] ?? 'No Title Provided';
    final String userBio = user['about'] ?? 'No bio available.';
    final List<dynamic> userSkills = user['skills'] ?? [];
    final String userProfilePic = user['profilePic'] ?? 
        'https://img.freepik.com/free-photo/business-man-by-skyscraper_1303-13655.jpg?ga=GA1.1.1378088882.1742949859&semt=ais_hybrid';
    final String userEmail = user['email'] ?? 'No Email Available';

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        actions: [
          // Mail icon to send email to the user
          IconButton(
            icon: Icon(Icons.email, color: Colors.white),
            onPressed: () {
              if (userEmail != 'No Email Available') {
                openOutlookEmail(userEmail);  // Attempt to open Outlook first
              } else {
                print('No email available');
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture with border and shadow
              Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: NetworkImage(userProfilePic),
                  backgroundColor: Colors.transparent,
                ),
              ),
              SizedBox(height: 20),

              // User Name and Title
              Center(
                child: Text(
                  userName,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  userTitle,
                  style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                ),
              ),
              SizedBox(height: 20),

              // Bio Section
              Card(
                elevation: 4,
                shadowColor: Colors.blueAccent.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bio:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        userBio,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Skills Section
              Card(
                elevation: 4,
                shadowColor: Colors.blueAccent.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Skills:',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        children: List.generate(userSkills.length, (index) {
                          return Chip(
                            label: Text(userSkills[index]),
                            backgroundColor: Colors.blueAccent,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
