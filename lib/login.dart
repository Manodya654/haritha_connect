import 'package:flutter/material.dart';
import 'package:haritha_connect/course_details.dart';
import 'package:haritha_connect/courses.dart';
import 'package:haritha_connect/job_details.dart';
import 'package:haritha_connect/jobs.dart';
import 'package:haritha_connect/profile.dart';


class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CourseDetailsView(),
      //home: JobDetailsPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    const Jobs(),
    const Courses(),
    const Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const NavigationDrawer(),
      body: Column(
        children: [

          // fixed app bar 
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),

            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    _scaffoldKey.currentState?.openDrawer();
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
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
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
                        SizedBox(width: 20),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Search here...",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          
          Expanded(
            child: _pages[_selectedIndex],
          ),
        ],
      ),

      // bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color.fromARGB(255, 64, 84, 178),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
      ),
    );
  }
}

// Home Page Widget
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

//add home page contents here in the home screen
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        "add home content hereeeeeee",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Navigation drawer from profile icon
class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

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
            accountName: const Text('Username', style: TextStyle(color: Colors.white, fontSize: 18)),
            accountEmail: const Text('username@gmail.com', style: TextStyle(color: Colors.white70)),
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