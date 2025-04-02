import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'user_search_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firestore Search',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UserSearchScreen(),
    );
  }
}
