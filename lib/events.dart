import 'package:flutter/material.dart';

class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: const Text('events'),
        automaticallyImplyLeading: false, // remove the menu icon (the hamburger icon)
      ),
    );
  }
}