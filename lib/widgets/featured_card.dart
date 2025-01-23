import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FeaturedCard extends StatelessWidget {
  final String title;
  final String description;
  final double price;

  const FeaturedCard({
    required this.title,
    required this.description,
    required this.price,
    Key? key,
    required imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 264,
      height: 172,
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color(0xFF3DA0A7),
        image: const DecorationImage(
          image: AssetImage('assets/images/card_background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Sofia Pro',
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              '\$$price',
              style: const TextStyle(
                fontFamily: 'Sofia Pro',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

class SearchProductCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final double price;

  const SearchProductCard({
    required this.title,
    required this.imageUrl,
    required this.price,
    Key? key,
  }) : super(key: key);

  @override
  State<SearchProductCard> createState() => _SearchProductCardState();
}

class _SearchProductCardState extends State<SearchProductCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 136,
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
                padding: const EdgeInsets.all(0.0),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  child: widget.imageUrl ==
                          'dummy' // Check if it's a dummy image URL
                      ? Image.asset(
                          'assets/images/card_background.png', // Replace with your dummy image path
                          height: 84,
                          width: 84,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          widget
                              .imageUrl, // Use the network image URL for real images
                          height: 84,
                          width: 84,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Sofia Pro',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EditorsChoiceCard extends StatelessWidget {
  final String title;
  final double price;
  final String imageUrl;

  const EditorsChoiceCard({
    required this.title,
    required this.price,
    required this.imageUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: imageUrl == 'dummy' // Check if it's a dummy image URL
                ? Image.asset(
                    'assets/images/card_background.png', // Replace with your dummy image path
                    height: 84,
                    width: 84,
                    fit: BoxFit.cover,
                  )
                : Image.network(
                    imageUrl, // Use the network image URL for real images
                    height: 84,
                    width: 84,
                    fit: BoxFit.cover,
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontFamily: 'Sofia Pro',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 12,
                      backgroundImage: AssetImage(
                        'assets/images/Icon.png',
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Author",
                      style: const TextStyle(
                        fontFamily: 'Sofia Pro',
                        fontSize: 14,
                        color: Colors.grey,
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
    );
  }
}

class ShoppingItemCard extends StatelessWidget {
  final String name;
  final String imagePath;
  final int count;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  ShoppingItemCard({
    required this.name,
    required this.imagePath,
    required this.count,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 327,
      height: 80,
      child: Card(
        color: Colors.white,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    imagePath.isNotEmpty
                        ? imagePath
                        : 'assets/images/placeholder.png',
                    width: 48,
                    height: 48,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.image_not_supported, size: 40);
                    },
                  ),
                  SizedBox(width: 15),
                  Text(
                    name,
                    style: TextStyle(
                        fontFamily: 'Sofia Pro',
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: onDecrement,
                    icon: Image.asset(
                      'assets/images/Negative.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                  Text(
                    count.toString(),
                    style: TextStyle(
                        fontFamily: 'Sofia Pro',
                        fontSize: 16,
                        fontWeight: FontWeight.w400),
                  ),
                  IconButton(
                    onPressed: onIncrement,
                    icon: Image.asset(
                      'assets/images/Plus.png',
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavouriteCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final double price;
  final num id;

  const FavouriteCard({
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<FavouriteCard> createState() => _FavouriteCardState();
}

class _FavouriteCardState extends State<FavouriteCard> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  // Load the favorite status from local storage
  Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // Use the product's id (converted to string) to store/retrieve the favorite status
      isFavorite = prefs.getBool(widget.id.toString()) ?? false;
    });
  }

  // Toggle favorite status and save it to local storage
  Future<void> _toggleFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isFavorite = !isFavorite;
    });
    // Save the favorite status with the product's id (converted to string) as the key
    await prefs.setBool(widget.id.toString(), isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 156,
      height: 198,
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
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image.network(
                      widget.imageUrl,
                      height: 88,
                      width: 132,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: _toggleFavorite,
                  child: Container(
                    padding: const EdgeInsets.all(8),
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
                      Icons.favorite,
                      color: Color(0xFF70B9BE),
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
                  maxLines: 1,
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
