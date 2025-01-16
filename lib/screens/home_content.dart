import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart'; // Import for toast
import '../services/api_service.dart';
import '../widgets/featured_card.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<dynamic> _products = [];

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await ApiService.getRandomProducts(3);
      setState(() {
        _products = products;
      });
    } catch (error) {
      // Show a toast message if there's an error
      Fluttertoast.showToast(
        msg: "Failed to load products: $error",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      // Log the error to the console for better debugging
      print("Error fetching products: $error");

      // Set dummy data for testing
      setState(() {
        _products = [
          {
            'title': 'Dummy Product 1',
            'description': 'This is a dummy product description.',
            'price': 29.99
          },
          {
            'title': 'Dummy Product 2',
            'description': 'This is another dummy product description.',
            'price': 19.99
          },
          {
            'title': 'Dummy Product 3',
            'description': 'Yet another dummy product description.',
            'price': 9.99
          },
        ];
      });
    }
  }

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
                      Image.asset(
                        'assets/images/sun.png',
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'Good Morning',
                        style: TextStyle(
                          fontFamily: 'Sofia Pro',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
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
                          style: TextStyle(color: Color(0xFF0A2533)),
                        );
                      }
                      return Text(
                        snapshot.data ?? 'Guest',
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
                icon:
                    Image.asset('assets/images/cart.png', color: Colors.black),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Featured',
              style: TextStyle(
                fontFamily: 'Sofia Pro',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          _products.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: 172,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _products.length,
                    itemBuilder: (context, index) {
                      final product = _products[index];
                      return FeaturedCard(
                        title: product['title'],
                        description: product['description'],
                        price: product['price'],
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
  await Future.delayed(const Duration(seconds: 1));
  return 'John Doe'; // Replace with actual username logic
}
