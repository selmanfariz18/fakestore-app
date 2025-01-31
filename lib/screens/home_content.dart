import 'dart:async';

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
      final result = await Future.any([
        ApiService.getRandomProducts(5), // Your API call
        Future.delayed(Duration(seconds: 3),
            () => throw TimeoutException("Timeout")) // Timeout after 3 seconds
      ]);

      // If the result is the products, set them
      setState(() {
        _products = result;
      });
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Failed to load products, No internet!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      // Fallback to dummy products if the error occurs or timeout
      setState(() {
        _products = [
          {
            'id': 1,
            'title': 'Dummy Product 1',
            'price': 20.00,
            'category': 'Category A',
            'description': 'This is a dummy product.',
            'image': 'dummy'
          },
          {
            'id': 2,
            'title': 'Dummy Product 2',
            'price': 30.00,
            'category': 'Category B',
            'description': 'This is another dummy product.',
            'image': 'dummy'
          },
          {
            'id': 3,
            'title': 'Dummy Product 3',
            'price': 40.00,
            'category': 'Category C',
            'description': 'Dummy product for fallback.',
            'image': 'dummy'
          },
          {
            'id': 4,
            'title': 'Dummy Product 4',
            'price': 50.00,
            'category': 'Category D',
            'description': 'Fallback dummy product.',
            'image': 'dummy'
          },
          {
            'id': 5,
            'title': 'Dummy Product 5',
            'price': 60.00,
            'category': 'Category E',
            'description': 'More dummy products.',
            'image': 'dummy'
          }
        ];
      });
    }
  }

  Future<void> _fetchCategories() async {
    try {
      final result = await Future.any([
        ApiService.getCategories(), // Your API call
        Future.delayed(Duration(seconds: 3),
            () => throw TimeoutException("Timeout")) // Timeout after 3 seconds
      ]);

      // If the result is categories, set them
      setState(() {
        _categories = result;
        _selectedCategory = _categories.isNotEmpty
            ? _categories.first
            : 'electronics'; // Default to 'electronics'
      });
    } catch (error) {
      Fluttertoast.showToast(
        msg: "Failed to load categories:  No internet!!",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );

      // Fallback to dummy categories if the error occurs or timeout
      setState(() {
        _categories = [
          "electronics",
          "jewelery",
          "men's clothing",
          "women's clothing"
        ];
        _selectedCategory = _categories.first; // Default to the first category
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
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                  icon: Image.asset('assets/images/cart.png',
                      color: Colors.black),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          toolbarHeight: 100.0,
        ),
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Featured',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0A2533),
                        ),
                      ),
                    ),
                    _products.isEmpty
                        ? Center(child: CircularProgressIndicator())
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Category',
                            style: TextStyle(
                              fontFamily: 'Sofia Pro',
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0A2533),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'See All',
                              style: TextStyle(
                                fontFamily: 'Sofia Pro',
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF3DA0A7),
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
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Popular Recipes',
                            style: TextStyle(
                              fontFamily: 'Sofia Pro',
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0A2533),
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              'See All',
                              style: TextStyle(
                                fontFamily: 'Sofia Pro',
                                fontSize: 14,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF3DA0A7),
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
                                  price: product['price'],
                                  imageUrl: product['image'],
                                  id: product['id'],
                                );
                              },
                            ),
                          ),
                    SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

Future<String?> _getUsername() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'John Doe';
}
