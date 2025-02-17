import 'package:flutter/material.dart';

class Courses extends StatelessWidget {
  const Courses({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: const Text('courses'),
        automaticallyImplyLeading: false, // remove the menu icon (the hamburger icon)
      ),
    );
  }
}