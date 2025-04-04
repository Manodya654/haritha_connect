import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui_connect/components/BottomNavBar.dart';
import 'package:ui_connect/pages/ADEvent.dart';
import 'package:ui_connect/pages/event_details.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  String? userType;

  Stream<QuerySnapshot> getEvents() {
    return FirebaseFirestore.instance.collection('events').snapshots();
  }

  Stream<QuerySnapshot> getEventsWorkshop() {
    return FirebaseFirestore.instance
        .collection('events')
        .where('EventType', isEqualTo: 'Workshop')
        .snapshots();
  }

  Stream<QuerySnapshot> getEventsEvent() {
    return FirebaseFirestore.instance
        .collection('events')
        .where('EventType', isEqualTo: 'Event')
        .snapshots();
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar Section
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundImage: NetworkImage(
                          'https://img.freepik.com/free-vector/professional-tiktok-profile-picture_742173-5866.jpg',
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search for Events...',
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CategoryButton(label: 'Events', color: Colors.white30),
                  const SizedBox(width: 10),
                  // Show the button only if userType is "club"
                  if (userType == "club")
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddEventScreen()),
                        );
                      },
                      icon: Icon(
                        Icons.add,
                        color: Colors.deepPurple,
                      ),
                    ),

                  const SizedBox(width: 10),
                ],
              ),
              // );
              SizedBox(height: 20),
              // Events Section
              SectionTitle(title: "This Week's Events"),
              Row(
                children: [
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: getEvents(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }

                        var events = snapshot.data!.docs;

                        // Get the current date
                        DateTime now = DateTime.now();
                        DateTime startOfWeek = now.subtract(
                            Duration(days: now.weekday - 1)); // Monday
                        DateTime endOfWeek =
                            startOfWeek.add(Duration(days: 6)); // Sunday

                        // Filter events happening in the current week
                        var weeklyEvents = events.where((event) {
                          DateTime eventDate;
                          try {
                            eventDate = DateFormat('yyyy-MM-dd').parse(event[
                                'date']); // Assuming date is in 'YYYY-MM-DD' format
                          } catch (e) {
                            return false; // Skip invalid date formats
                          }
                          return eventDate.isAfter(
                                  startOfWeek.subtract(Duration(days: 1))) &&
                              eventDate
                                  .isBefore(endOfWeek.add(Duration(days: 1)));
                        }).toList();

                        if (weeklyEvents.isEmpty) {
                          return Center(child: Text("No events this week"));
                        }

                        return SizedBox(
                          height: 150,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                weeklyEvents.length,
                                (index) {
                                  var event = weeklyEvents[index];
                                  return Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EventDetails(eventId: event.id),
                                          ),
                                        );
                                      },
                                      child: SizedBox(
                                        width: 160,
                                        child: EventCard(
                                          title: event['EventName'],
                                          organizer: event['OrganizerName'],
                                          date: event['date'],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Featured Event Section
              SectionTitle(title: "Featured Event"),

              StreamBuilder<QuerySnapshot>(
                stream: getEvents(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var events = snapshot.data!.docs;

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        events.length,
                        (index) {
                          var event = events[index];
                          return Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EventDetails(eventId: event.id),
                                  ),
                                );
                              },
                              child: SizedBox(
                                width: 355,
                                child: EventCard(
                                  title: event['EventName'],
                                  organizer: event['OrganizerName'],
                                  date: event['date'],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              // Workshops Section
              SectionTitle(title: "Workshops"),

              StreamBuilder<QuerySnapshot>(
                stream: getEventsWorkshop(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var events = snapshot.data!.docs;

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        events.length,
                        (index) {
                          var event = events[index];
                          return Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EventDetails(eventId: event.id),
                                  ),
                                );
                              },
                              child: SizedBox(
                                width: 355,
                                child: EventCard(
                                  title: event['EventName'],
                                  organizer: event['OrganizerName'],
                                  date: event['date'],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 20),

              SectionTitle(title: "Event"),

              StreamBuilder<QuerySnapshot>(
                stream: getEventsEvent(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  var events = snapshot.data!.docs;

                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        events.length,
                        (index) {
                          var event = events[index];
                          return Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EventDetails(eventId: event.id),
                                  ),
                                );
                              },
                              child: SizedBox(
                                width: 355,
                                child: EventCard(
                                  title: event['EventName'],
                                  organizer: event['OrganizerName'],
                                  date: event['date'],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Bottomnavbar(
        pageIndex: 1,
      ),
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final Color color;

  CategoryButton({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // FIXED: Updated primary color
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(label),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String organizer;
  final String date;

  const EventCard({
    required this.title,
    required this.organizer,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            organizer,
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 10),
          Text(date, style: TextStyle(color: Colors.white70, fontSize: 12)),
        ],
      ),
    );
  }
}

class FeaturedEventCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://img.freepik.com/free-psd/artificial-intelligence-template-design_23-2151631490.jpg',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Event 2',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text('By John Doe', style: TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            Text(
              '25/02/24',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
