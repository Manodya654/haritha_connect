import 'package:flutter/material.dart';

class Jobs extends StatelessWidget {
  const Jobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jobs'),
        automaticallyImplyLeading: false, // remove the menu icon (the hamburger icon)
      ),
    );
  }
}
