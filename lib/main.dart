import 'package:flutter/material.dart';
import 'package:haritha_connect/pages/ADEvent.dart';
import 'package:haritha_connect/pages/courses.dart';
import 'package:haritha_connect/pages/events.dart';
import 'package:haritha_connect/pages/jobs.dart';
import 'package:haritha_connect/pages/profile_page.dart';
import 'package:haritha_connect/pages/Additprofile.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    initialRoute: '/home',
    routes: {
      '/home': (context) => Jobs(),
      '/events': (context) => Events(),
      '/courses': (context) => Courses(),
      '/account': (context) => ProfilePage(),
      '/adevent': (context) => AddEventScreen(),
      '/addprofile':(context)=>AddProfileScreen(),
      '/profile':(context) => ProfilePage(),
    },
  ));
}
