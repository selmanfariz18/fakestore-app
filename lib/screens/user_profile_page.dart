import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../widgets/featured_card.dart';
import '../services/api_service.dart';

class UserProfilePage extends StatefulWidget {
  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  List<dynamic> _products = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchFavoriteProducts();
  }

  Future<void> _fetchFavoriteProducts() async {
    try {
      final products = await ApiService.getFavoriteProducts();
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });

      Fluttertoast.showToast(
        msg: "Failed to load favorite products, No internet!!",
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
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<String?>(
                    future: _getUsername(),
                    builder: (context, snapshot) {
                      return Text(
                        "Account",
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
                icon: Image.asset('assets/images/Setting.png',
                    color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
        ),
        toolbarHeight: 100.0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                width: 365,
                height: 80,
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
                      child: Image.asset(
                        "assets/images/profile.png",
                        height: 48,
                        width: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Alena Sabyan",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: 'Sofia Pro',
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Recipe Developer",
                            style: const TextStyle(
                              fontFamily: 'Sofia Pro',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF48525F),
                            ),
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
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'My Favorites',
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
            _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _products.isEmpty
                    ? const Center(child: Text("No favorites found"))
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                            childAspectRatio: 0.9,
                          ),
                          itemCount: _products.length,
                          itemBuilder: (context, index) {
                            final product = _products[index];
                            return FavouriteCard(
                              id: product['id'].toInt(),
                              title: product['title'],
                              price: product['price'].toDouble(),
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
  return 'John Doe';
}
