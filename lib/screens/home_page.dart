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
      extendBody: true,
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
        backgroundColor: Color(0xFF042628),
        shape: const CircleBorder(),
        child: Image.asset(
          'assets/images/Chef.png',
          width: 24,
          height: 24,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: Image.asset(
                  _selectedIndex == 0
                      ? 'assets/images/home.png'
                      : 'assets/images/menu_no_color.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: Image.asset(
                  _selectedIndex == 1
                      ? 'assets/images/Search_color.png'
                      : 'assets/images/search.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () => _onItemTapped(1),
              ),
              const SizedBox(width: 40), // Space for FAB notch
              IconButton(
                icon: Image.asset(
                  'assets/images/bell.png',
                  color: _selectedIndex == 3
                      ? Color(0xFF70B9BE)
                      : Color(0xFF97A2B0),
                ),
                onPressed: () => _onItemTapped(3),
              ),
              IconButton(
                icon: Image.asset(
                  _selectedIndex == 4
                      ? 'assets/images/user_color.png'
                      : 'assets/images/user.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () => _onItemTapped(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
