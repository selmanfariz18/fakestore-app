import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/featured_card.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  List<String> _categories = [];
  List<dynamic> _products = [];

  String _selectedCategory = '';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    _fetchCategories();
  }

  Future<void> _fetchCategories() async {
    try {
      final categories = await ApiService.getCategories();
      setState(() {
        _categories = categories;
        _selectedCategory = _categories.first;
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 98, right: 0),
          child: Text(
            'Search',
            style: TextStyle(
              fontFamily: 'Sofia Pro',
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 24,
            ),
          ),
        ),
        toolbarHeight: 100.0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _searchController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: const TextStyle(
                    color: Color(0xFF97A2B0),
                    fontFamily: 'Sofia Pro',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  prefixIcon: Image.asset(
                    'assets/images/search1.png',
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                ),
                style: const TextStyle(color: Colors.black, fontSize: 16),
                onChanged: (value) {
                  // Handle search query updates here
                  print('Search query: $value');
                },
              ),
              const SizedBox(height: 20),
              // const Center(
              //   child: Text(
              //     'Search Results Will Appear Here',
              //     style: TextStyle(fontSize: 16, color: Colors.grey),
              //   ),
              // ),
              const SizedBox(height: 5),
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
                              width: 118,
                              height: 41,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
                        fontSize: 20,
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
                      height: 136,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          final product = _products[index];
                          return SearchProductCard(
                            title: product['title'],
                            // description: product['description'],
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
                      "Editor's choice",
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
                          color: Color(0xFF3DA0A7), // Matches the theme color
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _products.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: _products.map((product) {
                        return EditorsChoiceCard(
                          title: product['title'],
                          price: product['price'],
                          imageUrl: product['image'],
                        );
                      }).toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
