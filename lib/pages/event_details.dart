import 'package:flutter/material.dart';
import 'package:haritha_learning/components/BottomNavBar.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key});

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: const Text('Event Details'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.bookmark_border,
              color: Colors.blue,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Organizer Name & Logo
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Highspeed Studios',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 70,
                  width: 70,
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  // child: const Icon(Icons.loop, color: Colors.blue),
                  child: Image.network(
                    "https://img.freepik.com/free-vector/illustration-photo-studio-stamp-banner_53876-6870.jpg?ga=GA1.1.1378088882.1742949859&semt=ais_hybrid",
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Event Name
            const Text(
              'event 1',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Date & Time
            Row(
              children: [
                InfoIcon(
                    // icon: Icon(Symbols.calendar_view_month),
                    icon: Icon(Icons.calendar_month),
                    color: Colors.purple),
                const SizedBox(width: 8),
                const Text('25/2/25  •  10:00 AM'),
              ],
            ),
            const SizedBox(height: 12),

            // Location
            Row(
              children: [
                InfoIcon(
                    // icon: Icon(Symbols.calendar_view_month),
                    icon: Icon(Icons.location_pin),
                    color: Colors.purple),
                const SizedBox(width: 8),
                const Text('FOC 009'),
              ],
            ),
            const SizedBox(height: 16),

            // Description
            const Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod...',
              style: TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 12),

            // Bullet Points
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                _BulletPoint(text: 'Sed ut perspiciatis unde omnis'),
                _BulletPoint(text: 'Doloremque laudantium'),
                _BulletPoint(text: 'Ipsa quae ab illo inventore'),
                _BulletPoint(text: 'Architecto beatae vitae dicta'),
                _BulletPoint(text: 'Sunt explicabo'),
              ],
            ),

            const Spacer(),

            // Join Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('JOIN', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Bottomnavbar(
        pageIndex: 3,
      ),
    );
  }
}

class InfoIcon extends StatelessWidget {
  final Icon icon;
  final Color color;

  const InfoIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
      ),
      // child: Icon(icon, color: color),
      child: icon,
    );
  }
}

// Bullet Point Widget
class _BulletPoint extends StatelessWidget {
  final String text;
  const _BulletPoint({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.check_circle, color: Colors.purple, size: 18),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
