import 'package:flutter/material.dart';
import 'package:haritha_connect/courses.dart';
import 'package:haritha_connect/job_details.dart';
import 'package:haritha_connect/profile.dart';



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
        '/profile': (BuildContext context) => Profile(),
        '/job_details': (BuildContext context) => JobDetailsPage(),
        '/courses': (BuildContext context) => Courses(),
      }
    );
  }
}
