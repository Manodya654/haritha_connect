import 'package:flutter/material.dart';
import 'package:haritha_connect/pages/courses.dart';
import 'package:haritha_connect/pages/Editprofile.dart';
import 'package:haritha_connect/pages/ADEvent.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: MainPage(),
      home: Courses(),
      routes: <String,WidgetBuilder>{
        '/courses': (BuildContext context) => Courses(),
        '/Editprofile': (BuildContext context) => EditProfileScreen(),
        '/ADEvent':(BuildContext context) => AddEventScreen(),
      }
    );
  }
}
