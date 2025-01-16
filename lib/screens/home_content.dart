import 'package:flutter/material.dart';

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Image.asset(
                            'assets/images/sun.png', // Path to your image
                            width: 30, // Set the width of the image
                            height: 30, // Set the height of the image
                          ),
                        ),
                      ),
                      // SizedBox(width: 2),
                      Text(
                        'Good Morning',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  FutureBuilder<String?>(
                    future: _getUsername(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text(
                          'Loading...',
                          style: TextStyle(color: Colors.grey),
                        );
                      }
                      return Text(
                        snapshot.data ?? 'Guest',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.black),
                onPressed: () {
                  // Handle cart button press
                },
              ),
            ],
          ),
        ),
        toolbarHeight: 100.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Featured',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4, // Number of featured cards
              itemBuilder: (context, index) {
                return Container(
                  width: 264,
                  height: 172,
                  margin: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: Colors.teal[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.star, size: 50, color: Colors.teal),
                      const SizedBox(height: 8),
                      Text(
                        'Item $index',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${(index + 1) * 10}',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

Future<String?> _getUsername() async {
  // Replace with actual shared preferences retrieval logic
  await Future.delayed(const Duration(seconds: 1));
  return 'John Doe'; // Replace with actual username
}
