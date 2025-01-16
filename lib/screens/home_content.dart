import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../services/api_service.dart';
import '../widgets/featured_card.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  List<dynamic> _products = [];
  List<String> _categories = [];
  String _selectedCategory = '';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _fetchCategories();
  }

  Future<void> _fetchProducts() async {
    try {
      final products = await ApiService.getRandomProducts(5);
      setState(() {
        _products = products;
      });
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Failed to load products: $error",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  Future<void> _fetchCategories() async {
    try {
      final categories = await ApiService.getCategories();
      setState(() {
        _categories = categories;
        _selectedCategory = _categories.first; // Default to the first category
      });
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Failed to load categories: $error",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
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
      body: SingleChildScrollView(
        child: Column(
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
                  color: Color(0xFF0A2533),
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
                          imageUrl: product['image'],
                        );
                      },
                    ),
                  ),
            SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Category',
                    style: TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0A2533),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle "See All" button press
                      // Fluttertoast.showToast(
                      //   msg: "See All Categories clicked!",
                      //   toastLength: Toast.LENGTH_SHORT,
                      //   gravity: ToastGravity.BOTTOM,
                      //   backgroundColor: Colors.blue,
                      //   textColor: Colors.white,
                      // );
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        fontFamily: 'Sofia Pro',
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF3DA0A7), // Matches the theme color
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _categories.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCategory = category;
                            });
                          },
                          child: Container(
                            width: 119,
                            height: 41,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: _selectedCategory == category
                                  ? const Color(0xFF3DA0A7)
                                  : Color(0xFFF1F5F5),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Center(
                              child: Text(
                                category,
                                maxLines: 1,
                                style: TextStyle(
                                  fontFamily: 'Sofia Pro',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: _selectedCategory == category
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
            SizedBox(height: 20),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Popular Recipes',
                    style: TextStyle(
                      fontFamily: 'Sofia Pro',
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF0A2533),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle "See All" button press
                      // Fluttertoast.showToast(
                      //   msg: "See All Categories clicked!",
                      //   toastLength: Toast.LENGTH_SHORT,
                      //   gravity: ToastGravity.BOTTOM,
                      //   backgroundColor: Colors.blue,
                      //   textColor: Colors.white,
                      // );
                    },
                    child: const Text(
                      'See All',
                      style: TextStyle(
                        fontFamily: 'Sofia Pro',
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF3DA0A7), // Matches the theme color
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _products.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: _products.length,
                      itemBuilder: (context, index) {
                        final product = _products[index];
                        return ProductCard(
                          title: product['title'],
                          // description: product['description'],
                          price: product['price'],
                          imageUrl: product['image'],
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

Future<String?> _getUsername() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'John Doe'; // Replace with actual username logic
}
