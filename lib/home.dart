import 'package:flutter/material.dart';
import 'package:connecting_pages_mad/components/NavigationDrawer.dart'
    as custom;
import 'package:connecting_pages_mad/components/BottomNavBar.dart';
import 'package:connecting_pages_mad/components/header.dart';

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
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      drawer: const custom.NavigationDrawer(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150), // Adjust height if needed
        child: HeaderWidget(scaffoldKey: _scaffoldKey), // Custom header
      ),
      body: Center(
        child: Text("Selected Index: $_selectedIndex",
            style: TextStyle(fontSize: 20)),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
