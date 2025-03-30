import 'package:flutter/material.dart';
import 'package:haritha_connect/pages/jobs.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/harithaimage1.jpeg', height: 250),
            SizedBox(height: 20),
            Text(
              'Find your job now',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                'Discover the best job opportunities tailored to your skills and interests.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle, size: 10, color: Colors.grey),
                SizedBox(width: 5),
                Icon(Icons.circle, size: 10, color: Colors.grey),
                SizedBox(width: 5),
                Icon(Icons.circle,
                    size: 10, color: const Color.fromARGB(255, 7, 82, 144)),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(15),
                    backgroundColor: const Color.fromARGB(255, 43, 103, 167),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Jobs()),
                    );
                  },
                  child: Icon(Icons.arrow_forward, color: Colors.white),
                ),
              ],
            ),
            SizedBox(width: 100),
          ],
        ),
      ),
    );
  }
}
