import 'package:flutter/material.dart';
import 'package:haritha_connect/components/BottomNavBar.dart';
import 'package:haritha_connect/pages/event_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:haritha_connect/service/Database.dart';

class Events extends StatefulWidget {
  const Events({super.key});

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
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
                            hintText: 'Search for jobs...',
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
                        DateTime startOfWeek = now.subtract(Duration(days: now.weekday - 1)); // Monday
                        DateTime endOfWeek = startOfWeek.add(Duration(days: 6)); // Sunday

                        // Filter events happening in the current week
                        var weeklyEvents = events.where((event) {
                          DateTime eventDate;
                          try {
                            eventDate = DateFormat('yyyy-MM-dd').parse(event['date']); // Assuming date is in 'YYYY-MM-DD' format
                          } catch (e) {
                            return false; // Skip invalid date formats
                          }
                          return eventDate.isAfter(startOfWeek.subtract(Duration(days: 1))) &&
                              eventDate.isBefore(endOfWeek.add(Duration(days: 1)));
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
                                            builder: (context) => EventDetails(eventId: event.id),
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
                                    builder: (context) => EventDetails(eventId: event.id),
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
                                    builder: (context) => EventDetails(eventId: event.id),
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
                                    builder: (context) => EventDetails(eventId: event.id),
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

  const CategoryButton({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 22),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
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

