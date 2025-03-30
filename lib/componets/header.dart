// import 'package:flutter/material.dart';
// import 'package:haritha_connect/components.dart';
// import 'package:haritha_connect/courses.dart';
// import 'package:haritha_connect/events.dart';
// import 'package:haritha_connect/home.dart';
// import 'package:haritha_connect/profile.dart';

// class HeaderPage extends StatefulWidget {
//   const HeaderPage({super.key});

//   @override
//   State<HeaderPage> createState() => _HeaderPageState();
// }

// class _HeaderPageState extends State<HeaderPage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   int _selectedIndex = 0;

//   final List<Widget> _pages = [
//     const HomeScreen(),
//     Events(),
//     Courses(),
//     Profile(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       drawer: const Drawer(),
//       body: Column(
//         children: [
//           Positioned.fill(
//             child: CurvedBackground(
//               height: 150,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 30),
//                   Container(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 15),
//                     child: Row(
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             _scaffoldKey.currentState?.openDrawer();
//                           },
//                           child: const CircleAvatar(
//                             radius: 22,
//                             backgroundImage: AssetImage('images/profile.jpg'),
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         Expanded(
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 10),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(30),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.2),
//                                   spreadRadius: 1,
//                                   blurRadius: 5,
//                                   offset: const Offset(0, 3),
//                                 ),
//                               ],
//                             ),
//                             child: const Row(
//                               children: [
//                                 Icon(Icons.search, color: Colors.grey),
//                                 SizedBox(width: 20),
//                                 Expanded(
//                                   child: TextField(
//                                     decoration: InputDecoration(
//                                       hintText: "Search here...",
//                                       border: InputBorder.none,
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Body content of the selected page
//           Expanded(
//             child: _pages[_selectedIndex],
//           ),
//         ],
//       ),

//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:haritha_connect/components.dart';

class HeaderWidget extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HeaderWidget({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return CurvedBackground(
      height: 120, // Reduced height for a sleeker look
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    scaffoldKey.currentState?.openDrawer();
                  },
                  child: const CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage('images/profile.jpg'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    height: 40, // **Smaller search bar**
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20), // Adjusted for a compact look
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey),
                        SizedBox(width: 10),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search...",
                              border: InputBorder.none,
                              isDense: true, // Makes text input more compact
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    // Action for chat icon (e.g., navigate to chat page)
                  },
                  child: const Icon(Icons.chat_bubble, color: Colors.white, size: 26), // **Chat icon**
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
