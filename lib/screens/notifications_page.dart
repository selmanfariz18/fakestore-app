import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
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
                  Text(
                    "Notifications",
                    style: const TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0A2533),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        toolbarHeight: 100.0,
      ),
      body: Container(
        color: Colors.white, // Apply background color to the container
        child: Center(
          child: Text(
            "No notification",
            style: const TextStyle(
              fontFamily: 'Sofia Pro',
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
    );
  }
}
