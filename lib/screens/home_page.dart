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
      backgroundColor: Colors.white.withOpacity(0.9),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        elevation: 0,
        color: Colors.white,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: _selectedIndex == 0
                    ? Image.asset(
                        'assets/images/home.png',
                        width: 24,
                        height: 24,
                      )
                    : Image.asset(
                        'assets/images/menu_no_color.png',
                        width: 24,
                        height: 24,
                      ),
                onPressed: () => _onItemTapped(0),
              ),
              IconButton(
                icon: _selectedIndex == 1
                    ? Image.asset(
                        'assets/images/Search_color.png',
                        width: 24,
                        height: 24,
                      )
                    : Image.asset(
                        'assets/images/search.png',
                        width: 24,
                        height: 24,
                      ),
                onPressed: () => _onItemTapped(1),
              ),
              const SizedBox(width: 40), // Space for notch
              IconButton(
                icon: Image.asset('assets/images/bell.png',
                    color: _selectedIndex == 3
                        ? Color(0xFF70B9BE)
                        : Color(0xFF97A2B0)),
                onPressed: () => _onItemTapped(3),
              ),
              IconButton(
                icon: _selectedIndex == 4
                    ? Image.asset(
                        'assets/images/user_color.png',
                        width: 24,
                        height: 24,
                      )
                    : Image.asset(
                        'assets/images/user.png',
                        width: 24,
                        height: 24,
                      ),
                onPressed: () => _onItemTapped(4),
              ),
            ],
          ),
        ),
      ),
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
    );
  }
}
