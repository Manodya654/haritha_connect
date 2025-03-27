import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        return Drawer(
      width: 250,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 64, 84, 178),
            ),
            accountName: const Text('Username',
                style: TextStyle(color: Colors.white, fontSize: 18)),
            accountEmail: const Text('username@gmail.com',
                style: TextStyle(color: Colors.white70)),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('images/profile.jpg'),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
          ),
          const ListTile(
            leading: Icon(Icons.layers),
            title: Text('Courses'),
          ),
          const ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Saved'),
          ),
          const ListTile(
            leading: Icon(Icons.event),
            title: Text('Events'),
          ),
          const Spacer(),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
