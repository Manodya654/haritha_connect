import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: const Text('profile'),
        automaticallyImplyLeading: false, // remove the menu icon (the hamburger icon)
      ),
    );
  }
}