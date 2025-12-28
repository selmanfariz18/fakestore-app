import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductCard extends StatefulWidget {
  final int id;
  final String title;
  final String imageUrl;
  final double price;

  const ProductCard({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    Key? key,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFavorite = false;
  List<String> favoriteProductIds = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    favoriteProductIds = prefs.getStringList('favorite_products') ?? [];
    setState(() {
      isFavorite = favoriteProductIds.contains(widget.id.toString());
    });
  }

  // Toggle favorite status and save it to SharedPreferences
  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      if (isFavorite) {
        favoriteProductIds.remove(widget.id.toString());
      } else {
        favoriteProductIds.add(widget.id.toString());
      }
      isFavorite = !isFavorite;
    });
    await prefs.setStringList('favorite_products', favoriteProductIds);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 240,
      margin: const EdgeInsets.only(left: 16, bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: widget.imageUrl ==
                          'dummy' // Check if it's a dummy product
                      ? Image.asset(
                          'assets/images/card_background.png', // Replace with your dummy image path
                          height: 128,
                          width: 168,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          widget
                              .imageUrl, // Use the network image URL for real products
                          height: 128,
                          width: 168,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: _toggleFavorite,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Color(0xFF70B9BE) : Color(0xFF130F26),
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Sofia Pro',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${widget.price}',
                  style: const TextStyle(
                    fontFamily: 'Sofia Pro',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
