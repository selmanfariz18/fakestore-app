import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<String?>(
                    future: _getUsername(),
                    builder: (context, snapshot) {
                      return Text(
                        "Account",
                        style: const TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF0A2533),
                        ),
                      );
                    },
                  ),
                ],
              ),
              IconButton(
                icon: Image.asset('assets/images/Setting.png',
                    color: Colors.black),
                onPressed: () {
                  // Handle cart button press
                },
              ),
            ],
          ),
        ),
        toolbarHeight: 100.0,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Center(
            child: Container(
              width: 365,
              height: 80,
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      "assets/images/profile.png",
                      height: 48,
                      width: 48,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Alena Sabyan",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontFamily: 'Sofia Pro',
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        // const SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              "Recipe Developer",
                              style: const TextStyle(
                                fontFamily: 'Sofia Pro',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF48525F),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/images/ArrowRight.png',
                    width: 24,
                    height: 24,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Future<String?> _getUsername() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'John Doe'; // Replace with actual username logic
}
