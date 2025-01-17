import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../widgets/featured_card.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MagicPage extends StatefulWidget {
  @override
  _MagicPageState createState() => _MagicPageState();
}

class _MagicPageState extends State<MagicPage> {
  bool isIngredientsSelected = true;
  Map<String, dynamic>? product;
  bool isExpanded = false;
  List<dynamic> _products = [];
  List<Map<String, dynamic>> items = [
    {
      'name': 'Tortilla Chips',
      'image': 'assets/images/ingredient1.png',
      'count': 2
    },
    {'name': 'Avocado', 'image': 'assets/images/ingredient2.png', 'count': 1},
    {
      'name': 'Red Cabbage',
      'image': 'assets/images/ingredient3.png',
      'count': 9
    },
    {'name': 'Peanuts', 'image': 'assets/images/ingredient4.png', 'count': 1},
    {
      'name': 'Red Onions',
      'image': 'assets/images/ingredient5.png',
      'count': 1
    },
  ];

  @override
  void initState() {
    super.initState();
    // Fetch product details from the API
    _loadProductDetails();
    _fetchProducts();
  }

  Future<void> _loadProductDetails() async {
    product = await ApiService.fetchProductDetails();
    setState(() {});
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: product == null
          ? Center(
              child: CircularProgressIndicator(),
            ) // Show loading indicator if product is null
          : Stack(
              children: [
                // Background Image
                Positioned(
                  top: 60,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 300, // Set the height of the image
                    width: MediaQuery.of(context)
                        .size
                        .width, // Set the width of the image
                    child: product!['image'] != null
                        ? Image.network(
                            product!['image'], // Use fetched image
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/taco_salad.jpg', // Use default image if no fetched image
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                // Content with overlapping container
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height * 0.4,
                      pinned: true,
                      stretch: true,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      leading: Container(
                        width: 40, // Set the width of the image
                        height: 60, // Set the height of the image
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            'assets/images/Cancel.png', // Path to your image
                            fit: BoxFit
                                .contain, // Adjust image to fit the container
                          ),
                        ),
                      ),
                      actions: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10)),
                            child: IconButton(
                              icon: Icon(Icons.favorite_border,
                                  color:
                                      Color(0xFF130F26)), // Set the icon color
                              onPressed: () {
                                // Add favorite functionality here
                              },
                            ),
                          ),
                        ),
                      ],
                      flexibleSpace: FlexibleSpaceBar(
                        background: Container(
                          color: Colors.transparent, // Keeps AppBar transparent
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          // Overlapping container
                          Container(
                            transform: Matrix4.translationValues(
                                0, -50, 0), // Move upward
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 1),
                                // divider
                                Center(
                                  child: Container(
                                    width: 50,
                                    height: 5,
                                    color: Color(0xFFEBF0F6),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Text(
                                  product!['title'] ?? 'Healthy Taco Salad',
                                  style: TextStyle(
                                    fontFamily: 'Sofia Pro',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Row(
                                  children: [
                                    Icon(Icons.access_time,
                                        size: 18, color: Colors.grey),
                                    SizedBox(width: 5),
                                    Text(
                                      (product!['price'] ?? "15 Min")
                                          .toString(),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Sofia Pro',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Stack(
                                  children: [
                                    Text(
                                      product!['description'] ??
                                          'This Healthy Taco Salad is the universal delight of taco night',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontFamily: 'Sofia Pro',
                                      ),
                                      maxLines: isExpanded
                                          ? null
                                          : 2, // Limit lines to 2 unless expanded
                                      overflow: isExpanded
                                          ? TextOverflow.visible
                                          : TextOverflow.ellipsis,
                                    ),
                                    if (!isExpanded)
                                      Positioned(
                                        bottom: 1,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              isExpanded = !isExpanded;
                                            });
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                            ),
                                            child: Text(
                                              "View More",
                                              style: TextStyle(
                                                color: Color(
                                                    0xFF748189), // Text color
                                                fontWeight: FontWeight.w800,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 0),
                                        _buildNutritionInfo("65g carbs",
                                            "assets/images/Icon.png"),
                                        SizedBox(width: 75),
                                        _buildNutritionInfo("120 Kcal",
                                            "assets/images/Icon1.png"),
                                      ],
                                    ),
                                    SizedBox(height: 20), // Space between rows
                                    Row(
                                      children: [
                                        SizedBox(width: 0),
                                        _buildNutritionInfo("27g protein",
                                            "assets/images/Icon2.png"),
                                        SizedBox(width: 75),
                                        _buildNutritionInfo("91g fats",
                                            "assets/images/Icon3.png"),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Container(
                                  width: 370,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Color(0xFFE6EBF2),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Stack(
                                    children: [
                                      AnimatedAlign(
                                        duration: Duration(milliseconds: 300),
                                        alignment: isIngredientsSelected
                                            ? Alignment.centerLeft
                                            : Alignment.centerRight,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Container(
                                            width: 165,
                                            height: 46,
                                            decoration: BoxDecoration(
                                              color: Color(
                                                  0xFF002B2E), // Active button color
                                              borderRadius: BorderRadius.circular(
                                                  16), // Adjust the border radius here if needed
                                            ),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isIngredientsSelected = true;
                                                });
                                              },
                                              child: Center(
                                                child: Text(
                                                  'Ingredients',
                                                  style: TextStyle(
                                                    color: isIngredientsSelected
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                    fontFamily: 'Sofia Pro',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  isIngredientsSelected = false;
                                                });
                                              },
                                              child: Center(
                                                child: Text(
                                                  'Instructions',
                                                  style: TextStyle(
                                                    color: isIngredientsSelected
                                                        ? Colors.black
                                                        : Colors.white,
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                    fontFamily: 'Sofia Pro',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                        // This makes the column take all the remaining space in the row
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Ingredients',
                                              style: TextStyle(
                                                fontFamily: 'Sofia Pro',
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800,
                                                color: Color(0xFF0A2533),
                                              ),
                                            ),
                                            Text(
                                              '6 Item',
                                              style: TextStyle(
                                                fontFamily: 'Sofia Pro',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF748189),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          // Handle "See All" button press
                                        },
                                        child: const Text(
                                          'Add All to Cart',
                                          style: TextStyle(
                                            fontFamily: 'Sofia Pro',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w800,
                                            color: Color(
                                                0xFF3DA0A7), // Matches the theme color
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  transform:
                                      Matrix4.translationValues(0, -25, 0),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: items.length,
                                    itemBuilder: (context, index) {
                                      return ShoppingItemCard(
                                        name: items[index]['name'],
                                        imagePath: items[index]['image'],
                                        count: items[index]['count'],
                                        onIncrement: () {
                                          setState(() {
                                            items[index]['count']++;
                                          });
                                        },
                                        onDecrement: () {
                                          setState(() {
                                            if (items[index]['count'] > 0) {
                                              items[index]['count']--;
                                            }
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    height: 54,
                                    width: 368,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFF83C5BE),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 15),
                                      ),
                                      child: const Text(
                                        'Add To Cart',
                                        style: TextStyle(
                                          fontFamily: 'Sofia Pro',
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                // divider
                                Center(
                                  child: Container(
                                    width: 368,
                                    height: 1,
                                    color: Color(0xFFEBF0F6),
                                  ),
                                ),
                                SizedBox(height: 20),
                                const Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0.0, vertical: 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Expanded(
                                        // This makes the column take all the remaining space in the row
                                        child: Text(
                                          'Creator',
                                          style: TextStyle(
                                            fontFamily: 'Sofia Pro',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                            color: Color(0xFF0A2533),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        'assets/images/profile.png',
                                        height: 48,
                                        width: 48,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
                                            "Natalia Luca",
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontFamily: 'Sofia Pro',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xFF0A2533)),
                                          ),
                                          const SizedBox(height: 8),
                                          const Row(
                                            children: [
                                              const SizedBox(width: 8),
                                              Text(
                                                "I'm the author and recipe developer.",
                                                style: const TextStyle(
                                                  fontFamily: 'Sofia Pro',
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 14,
                                                  color: Color(0xFF48525F),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Related Recipes',
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
                                            color: Color(
                                                0xFF3DA0A7), // Matches the theme color
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                _products.isEmpty
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : Transform.translate(
                                        offset: Offset(-15, 0),
                                        child: SizedBox(
                                          height: 136,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemCount: _products.length,
                                            itemBuilder: (context, index) {
                                              final product = _products[index];
                                              return SearchProductCard(
                                                title: product['title'],
                                                price: product['price'],
                                                imageUrl: product['image'],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _buildNutritionInfo(String text, String assetPath) {
    return Container(
      width: 125,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(
            assetPath,
            width: 40,
            height: 40,
          ),
          SizedBox(width: 8),
          Flexible(
            child: Text(
              text,
              style: TextStyle(
                fontFamily: 'Sofia Pro',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
