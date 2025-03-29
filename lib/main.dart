import 'package:flutter/material.dart';
import 'package:haritha_connect/courses.dart';
import 'package:haritha_connect/event_details.dart';
import 'package:haritha_connect/eventsall.dart';
import 'package:haritha_connect/job_details.dart';
import 'package:haritha_connect/search.dart';
import 'package:haritha_connect/profile.dart';

import 'extra.dart';

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
        '/search': (BuildContext context) => Search(),
        '/profile': (BuildContext context) => Profile(),
        '/event_details': (BuildContext context) => EventDetails(),
        '/eventsall': (BuildContext context) => EventsAll(),
        '/job_details': (BuildContext context) => JobDetailsPage(),
        '/courses': (BuildContext context) => Courses(),
        '/home': (BuildContext context) => MainPage(),
      }
    );
  }
}
