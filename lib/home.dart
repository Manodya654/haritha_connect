import 'package:flutter/material.dart';
import 'package:haritha_connect/componets/NavigationDrawer.dart';
import 'package:haritha_connect/componets/BottomNavBar.dart';
import 'package:haritha_connect/componets/header.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: HeaderWidget(),
        drawer: NavigationDrawer(),
        body: Center(
          child: Text("Selected Index: $_selectedIndex", style: TextStyle(fontSize: 20)),
        ),
        bottomNavigationBar: BottomNavBar(currentIndex: _selectedIndex, onTap: _onItemTapped),
      );
  }
}
