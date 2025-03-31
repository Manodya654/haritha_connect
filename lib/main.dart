import 'package:flutter/material.dart';
import 'package:haritha_connect/pages/courses.dart';
import 'package:haritha_connect/pages/events.dart';
import 'package:haritha_connect/pages/jobs.dart';
import 'package:haritha_connect/pages/profile_page.dart';
import 'package:ui_connect/pages/login.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  // runApp(const MyApp());
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
      '/home': (context) => Jobs(),
      '/events': (context) => Events(),
      '/courses': (context) => Courses(),
      '/account': (context) => ProfilePage(),
    },
  ));
}
