import 'package:flutter/material.dart';

class Saved extends StatelessWidget {
  const Saved({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: const Text('Saved'),
        automaticallyImplyLeading: false, 
      ),
    );
  }
}
