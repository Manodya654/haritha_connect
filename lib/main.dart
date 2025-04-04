import 'package:flutter/material.dart';
import 'package:ui_connect/pages/courses.dart';
import 'package:ui_connect/pages/events.dart';
import 'package:ui_connect/pages/jobs.dart';
import 'package:ui_connect/pages/login.dart';
import 'package:ui_connect/pages/profile_page.dart';
import 'package:ui_connect/pages/search_people.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    initialRoute: '/login',
    routes: {
      '/login': (context) => Login(),
      '/job': (context) => Jobs(),
      '/events': (context) => Events(),
      '/searchPeople': (context) => UserSearchScreen(),
      '/courses': (context) => Courses(),
      '/account': (context) => ProfilePage(),
    },
  ));
}
