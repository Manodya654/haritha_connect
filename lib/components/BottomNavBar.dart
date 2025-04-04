import 'package:flutter/material.dart';

class Bottomnavbar extends StatelessWidget {
  final int pageIndex;

  const Bottomnavbar({super.key, this.pageIndex = 1});

  void _onItemTapped(BuildContext context, int index) {
    if (index == pageIndex) return; // Prevent unnecessary navigation

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/job');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/events');
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/searchPeople');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/courses');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/account');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      currentIndex: pageIndex,
      onTap: (index) => _onItemTapped(context, index),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.badge), label: "Jobs"),
        BottomNavigationBarItem(icon: Icon(Icons.event), label: "Events"),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_search), label: "People"),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: "Courses"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
      ],
    );
  }
}
