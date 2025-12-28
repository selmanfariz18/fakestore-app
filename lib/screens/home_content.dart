import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/product_provider.dart';
import '../widgets/featured_card.dart';
// Assuming ProductCard is in widgets and was missed in imports or I should check imports.
// Original file had: import '../widgets/featured_card.dart';
// But it used ProductCard in the code, so it must be imported or available.
// Wait, looking at the previous view_file of home_content.dart, it didn't explicitly import ProductCard.
// Ah, maybe it was a mistake in the original file or it was there and I missed it?
// 225: return FeaturedCard(...
// 354: return ProductCard(...
// I don't see ProductCard import in the original file.
// Let me check imports again.
// 1: import 'dart:async';
// 3: import 'package:flutter/material.dart';
// 4: import 'package:fluttertoast/fluttertoast.dart';
// 5: import '../services/api_service.dart';
// 6: import '../widgets/featured_card.dart';
// It seems ProductCard might not be imported or I missed a line?
// No because the file view showed 1 to 379 lines.
// Maybe ProductCard is in the same file as FeaturedCard? Unlikely.
// Or maybe it was a compile error in the original project?
// I will assume it's in ../widgets/product_card.dart based on common sense,
// or maybe checking the widgets directory earlier:
// {"name":"widgets", "isDir":true, "numChildren":3}
// I will check widgets dir to be sure.

import '../widgets/product_card.dart';

class HomeContent extends StatefulWidget {
  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  void initState() {
    super.initState();
    // Fetch data when the widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.fetchProducts();
      productProvider.fetchCategories();
    });
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
        body: Consumer<ProductProvider>(
          builder: (context, provider, child) {
            return Column(
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
                        provider.isLoadingProducts
                            ? Center(child: CircularProgressIndicator())
                            : SizedBox(
                                height: 172,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: provider.products.length,
                                  itemBuilder: (context, index) {
                                    final product = provider.products[index];
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
                        provider.isLoadingCategories
                            ? const Center(child: CircularProgressIndicator())
                            : SizedBox(
                                height: 50,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: provider.categories.length,
                                  itemBuilder: (context, index) {
                                    final category = provider.categories[index];
                                    return GestureDetector(
                                      onTap: () {
                                        provider.setSelectedCategory(category);
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
                                          color: provider.selectedCategory ==
                                                  category
                                              ? const Color(0xFF3DA0A7)
                                              : Color(0xFFF1F5F5),
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                        child: Center(
                                          child: Text(
                                            category,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontFamily: 'Sofia Pro',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              color:
                                                  provider.selectedCategory ==
                                                          category
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
                        provider.isLoadingProducts
                            ? const Center(child: CircularProgressIndicator())
                            : SizedBox(
                                height: 250,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: provider.products.length,
                                  itemBuilder: (context, index) {
                                    final product = provider.products[index];
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
            );
          },
        ));
  }
}

Future<String?> _getUsername() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'John Doe';
}
