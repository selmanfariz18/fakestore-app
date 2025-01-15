import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF70B9BE), // Background color
      body: Stack(
        children: [
          // Middle images
          Positioned(
            top: 100,
            left: 50,
            child:
                Image.asset('assets/images/image1.png', width: 50, height: 50),
          ),
          Positioned(
            top: 200,
            right: 70,
            child:
                Image.asset('assets/images/image2.png', width: 40, height: 40),
          ),
          Positioned(
            bottom: 300,
            left: 20,
            child:
                Image.asset('assets/images/image3.png', width: 60, height: 60),
          ),
          // "Later" button
          Positioned(
            top: 40,
            right: 20,
            child: TextButton(
              onPressed: () {
                // Handle "Later" action
              },
              child: const Text(
                'Later',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          // Login and Create Account buttons
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.teal,
                      backgroundColor: Colors.white, // Button text color
                      minimumSize: const Size(200, 50),
                    ),
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.teal, // Button text color
                      minimumSize: const Size(200, 50),
                    ),
                    child: const Text('Create a New Account'),
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
