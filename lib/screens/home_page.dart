import 'package:flutter/material.dart';
import 'home_content.dart';
import 'search_page.dart';
import 'magic_page.dart';
import 'notifications_page.dart';
import 'user_profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomeContent(),
    SearchPage(),
    MagicPage(),
    NotificationsPage(),
    UserProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        elevation: 5.0,
        color: Colors.white, // Light background
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Image.asset(
                  'assets/images/home.png',
                  color: _selectedIndex == 0
                      ? Color(0xFF70B9BE)
                      : Color(0xFF97A2B0),
                  width: 30, // Set the size of the icon
                ),
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: Image.asset('assets/images/search.png',
                    color: _selectedIndex == 1
                        ? Color(0xFF70B9BE)
                        : Color(0xFF97A2B0)),
                onPressed: () => _onItemTapped(1),
              ),
              const SizedBox(width: 40), // Space for FAB
              IconButton(
                icon: Image.asset('assets/images/bell.png',
                    color: _selectedIndex == 3
                        ? Color(0xFF70B9BE)
                        : Color(0xFF97A2B0)),
                onPressed: () => _onItemTapped(3),
              ),
              IconButton(
                icon: Image.asset('assets/images/user.png',
                    color: _selectedIndex == 4
                        ? Color(0xFF70B9BE)
                        : Color(0xFF97A2B0)),
                onPressed: () => _onItemTapped(4),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _selectedIndex = 2; // Navigate to MagicPage
          });
        },
        backgroundColor: Colors.black, // Match dark FAB background
        elevation: 4,
        shape: const CircleBorder(),
        child: Image.asset(
          'assets/images/Chef.png', // Path to your image
          // color: Colors.white, // Optionally apply color filter
          width: 24, // Set the size of the image
          height: 24, // Set the size of the image
        ), // Chef icon
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
