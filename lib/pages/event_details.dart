import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ui_connect/components/BottomNavBar.dart';
import 'package:ui_connect/components/bookmarkButton.dart';
import 'package:ui_connect/components/join_button.dart';
import 'package:ui_connect/pages/profile_page.dart';

class EventDetails extends StatefulWidget {
  final String eventId;
  const EventDetails({Key? key, required this.eventId}) : super(key: key);

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  Map<String, dynamic>? eventData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEventDetails();
  }

  Future<void> fetchEventDetails() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("events")
          .doc(widget.eventId)
          .get();

      if (snapshot.exists) {
        setState(() {
          eventData = snapshot.data() as Map<String, dynamic>;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching event: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Event Details'),
        // actions: const [BookmarkButton()],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : eventData == null
              ? const Center(child: Text("Event not found"))
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Organizer & Logo
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            eventData!['OrganizerName'] ?? "Unknown Organizer",
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                              color: Colors.blue.shade100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.network(
                              eventData!['EventPicture'] ??
                                  "https://via.placeholder.com/70",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Event Name
                      Text(
                        eventData!['EventName'] ?? "Event Name",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),

                      // Date & Time
                      Row(
                        children: [
                          const Icon(Icons.calendar_month,
                              color: Colors.purple),
                          const SizedBox(width: 8),
                          Text(eventData!['date'] + " • " + eventData!['time']),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Location
                      Row(
                        children: [
                          const Icon(Icons.location_pin, color: Colors.purple),
                          const SizedBox(width: 8),
                          Text(eventData!['EventLocation'] ?? "No Location"),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Description
                      const Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(eventData!['EventDescription'] ??
                          "No Description Available"),
                      const Spacer(),

                      // Join Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          JoinButton(
                              joinButtonText: "Join",
                              joinLink: eventData!['EventJoinLink'] ?? ''),
                        ],
                      ),
                    ],
                  ),
                ),
      bottomNavigationBar: Bottomnavbar(pageIndex: 1),
    );
  }
}
