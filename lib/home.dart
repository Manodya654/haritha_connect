import 'package:flutter/material.dart';
import 'package:haritha_connect/componets/app_drawer.dart';
// import 'package:haritha_connect/componets/bottom_nav_bar.dart.dart';
// import 'package:haritha_connect/componets/header.dart.dart';

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
    return Scaffold(
      // appBar: Header(),
      drawer: AppDrawer(),
      body: Center(
        child: Text("Selected Index: $_selectedIndex", style: TextStyle(fontSize: 20)),
      ),
      // bottomNavigationBar: BottomNavBar(currentIndex: _selectedIndex, onTap: _onItemTapped),
    );
  }
}
