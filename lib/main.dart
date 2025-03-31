import 'package:flutter/material.dart';
import 'package:haritha_connect/pages/courses.dart';
import 'package:haritha_connect/pages/events.dart';
import 'package:haritha_connect/pages/jobs.dart';
import 'package:haritha_connect/pages/profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // runApp(const MyApp());
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
    },
  ));
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: ProfilePage(),
//     );
//   }
// }
