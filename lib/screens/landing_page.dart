import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF70B9BE), // Background color
      body: Stack(
        children: [
          // Middle images
          Positioned(
            top: -20,
            left: -203,
            child: Container(
              child: Image.asset(
                'assets/images/Pattern.png',
                width: 810.64,
                height: 859.55,
              ),
            ),
          ),
          Positioned(
            top: 180,
            left: 233,
            child: Image.asset('assets/images/image1.png',
                width: 86.46, height: 79.96),
          ),
          Positioned(
            top: 175,
            left: 72,
            child: Image.asset('assets/images/image2.png',
                width: 79.34, height: 71.75),
          ),
          Positioned(
            top: 238,
            left: 61.75,
            child: Image.asset('assets/images/image3.png',
                width: 10.75, height: 14.36),
          ),
          Positioned(
            top: 163,
            left: 33.89,
            child: Image.asset('assets/images/Illustration.png',
                width: 311.11, height: 310.56),
          ),
          Positioned(
            top: 291,
            left: 211,
            child: Image.asset('assets/images/Group.png',
                width: 47.8, height: 47.8),
          ),
          Positioned(
            top: 285,
            left: 110.59,
            child: Image.asset('assets/images/Group1.png',
                width: 47.78, height: 42.31),
          ),
          Positioned(
            top: 308,
            left: 104,
            child: Image.asset('assets/images/Group1.png',
                width: 47.78, height: 42.31),
          ),
          Positioned(
            top: 376,
            left: 67,
            child: Image.asset('assets/images/Group2.png',
                width: 87.22, height: 90),
          ),
          Positioned(
            top: 353,
            left: 207,
            child: Image.asset('assets/images/Group3.png',
                width: 129.71, height: 103),
          ),

          // "Later" button
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.setString('username', 'Guest');
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: const Text(
                'Later',
                style: TextStyle(
                    fontFamily: 'Sofia Pro', color: Colors.white, fontSize: 16),
              ),
            ),
          ),

          // Login and Create Account buttons with the text above them
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Text above the login button
                  const Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Help your path to health goals with happiness",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Sofia Pro',
                        fontWeight: FontWeight.w800,
                        fontSize: 28,
                        height: 36.4 / 28, // Line height / font size
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 327,
                    height: 54,
                    decoration: BoxDecoration(
                      color: const Color(0xFF042628),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 40), // Reduced horizontal padding
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'Sofia Pro',
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 327,
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      child: const Text(
                        'Create a New Account',
                        textAlign: TextAlign.center, // Correctly placed here
                        style: TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          height: 21.6 / 16, // Line height / font size
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
