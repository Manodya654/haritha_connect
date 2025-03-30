import 'package:flutter/material.dart';
import 'package:haritha_connect/addEvents.dart';
import 'package:haritha_connect/componets/BottomNavBar.dart';
import 'package:haritha_connect/componets/NavigationDrawer.dart' as custom;
import 'package:haritha_connect/componets/header.dart';
import 'package:haritha_connect/event_details.dart';

class Events extends StatelessWidget {
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     key: _scaffoldKey,
      drawer: const custom.NavigationDrawer(), // Custom navigation drawer
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150), // Adjust height if needed
        child: HeaderWidget(scaffoldKey: _scaffoldKey), // Custom header
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Events Section
              SectionTitle(title: "This Week's Events"),
               const SizedBox(height: 15),
              Row(
  children: [
    Expanded(
      child: GestureDetector(
        onTap: () {
          // Navigate to another page (replace with your destination)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EventDetails()), // Your destination page
          );
        },
        child: EventCard(
          title: 'Event 1',
          organizer: 'Organizer Name',
          date: '25/02/24',
        ),
      ),
    ),
    const SizedBox(width: 10),
    Expanded(
      child: GestureDetector(
        onTap: () {
          // Navigate to another page (replace with your destination)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EventDetails()), // Your destination page
          );
        },
        child: EventCard(
          title: 'Event 2',
          organizer: 'Organizer Name',
          date: '25/02/24',
        ),
      ),
    ),
  ],
),


              const SizedBox(height: 20),

              // Featured Event Section
              SectionTitle(title: "Featured Event"),
              FeaturedEventCard(),

              const SizedBox(height: 30),

              // Workshops Section
              SectionTitle(title: "Workshops"),
               const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: EventCard(
                      title: 'Workshop 1',
                      organizer: 'Organizer Name',
                      date: '25/02/24',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: EventCard(
                      title: 'workshop 2',
                      organizer: 'Organizer Name',
                      date: '25/02/24',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddEventScreen()), 
            );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavBar(),
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

class FeaturedEventCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
  padding: EdgeInsets.all(15),
  child: Column( // Use Column instead of Row
    crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          'images/course1.png',
          height: 200,
          width: double.infinity, // Makes the image take full width
          fit: BoxFit.cover, // Ensures it fits nicely
        ),
      ),
      const SizedBox(height: 12), // Space between image and text
      Text(
        'Event 2',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      Column(
        children: [
          Text('By John Doe', style: TextStyle(color: Colors.grey)),
        ],
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: Text(
          '25/02/24',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ),
    ],
  ),
),

    );
  }
}
