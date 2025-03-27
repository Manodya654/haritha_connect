import 'package:flutter/material.dart';

class Bottomnavbar extends StatelessWidget {
  final int pageIndex;

  const Bottomnavbar({this.pageIndex = 1});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      currentIndex: pageIndex,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.work), label: "Jobs"),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: "Courses"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
      ],
    );
  }
}

class CategoryButton extends StatelessWidget {
  final String label;
  final Color color;

  CategoryButton({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // FIXED: Updated primary color
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(label),
    );
  }
}
