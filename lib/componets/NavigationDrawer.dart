import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      backgroundColor: Colors.grey[200], // Ensures background isn't white
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 64, 84, 178),
            ),
            accountName: const Text(
              'Username',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            accountEmail: const Text(
              'username@gmail.com',
              style: TextStyle(color: Colors.white70),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('images/profile.jpg'),
              backgroundColor: Colors.transparent, // Prevents white background
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context); // Close drawer
            },
          ),
          ListTile(
            leading: const Icon(Icons.layers),
            title: const Text('Courses'),
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('Saved'),
          ),
          ListTile(
            leading: const Icon(Icons.event),
            title: const Text('Events'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// class NavigationDrawer extends StatelessWidget {
//   const NavigationDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       width: 250,
//       child: Column(
//         children: [
//           UserAccountsDrawerHeader(
//             decoration: const BoxDecoration(
//               color: Color.fromARGB(255, 64, 84, 178),
//             ),
//             accountName: const Text('Username',
//                 style: TextStyle(color: Colors.white, fontSize: 18)),
//             accountEmail: const Text('username@gmail.com',
//                 style: TextStyle(color: Colors.white70)),
//             currentAccountPicture: const CircleAvatar(
//               backgroundImage: AssetImage('images/profile.jpg'),
//             ),
//           ),
//           const ListTile(
//             leading: Icon(Icons.home),
//             title: Text('Home'),
//           ),
//           const ListTile(
//             leading: Icon(Icons.layers),
//             title: Text('Courses'),
//           ),
//           const ListTile(
//             leading: Icon(Icons.bookmark),
//             title: Text('Saved'),
//           ),
//           const ListTile(
//             leading: Icon(Icons.event),
//             title: Text('Events'),
//           ),
//           const Spacer(),
//           const Divider(),
//           const ListTile(
//             leading: Icon(Icons.settings),
//             title: Text('Settings'),
//           ),
//         ],
//       ),
//     );
//   }
// }
