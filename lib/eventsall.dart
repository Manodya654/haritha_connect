import 'package:flutter/material.dart';

class EventsAll extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Events Section
              SectionTitle(title: "This Week's Events"),
              Row(
                children: [
                  Expanded(
                    child: EventCard(
                      title: 'Event 1',
                      organizer: 'Organizer Name',
                      date: '25/02/24',
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: EventCard(
                      title: 'Event 2',
                      organizer: 'Organizer Name',
                      date: '25/02/24',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Featured Event Section
              SectionTitle(title: "Featured Event"),
              FeaturedEventCard(),

              const SizedBox(height: 20),

              // Workshops Section
              SectionTitle(title: "Workshops"),
              EventCard(
                title: 'Workshop 1',
                organizer: 'Organizer Name',
                date: '25/02/24',
              ),
            ],
          ),
        ),
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
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              child: Image.asset(
                'images/course1.png', 
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
