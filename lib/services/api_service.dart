import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'https://fakestoreapi.com';

  // Signup method
  Future<Map<String, dynamic>> signup(Map<String, dynamic> userData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print('Response: ${response.body}');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign up: ${response.statusCode}');
    }
  }

  // Login method
  Future<Map<String, dynamic>> login(Map<String, dynamic> credentials) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(credentials),
    );

    if (response.statusCode == 200) {
      print('Response: ${response.body}');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to log in: ${response.statusCode}');
    }
  }

  static Future<List<dynamic>> getRandomProducts(int count) async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      try {
        final List<dynamic> products = json.decode(response.body);
        final random = Random();

        // Normalize prices to double
        final normalizedProducts = products.map((product) {
          product['price'] = (product['price'] is int)
              ? (product['price'] as int).toDouble()
              : product['price'];
          return product;
        }).toList();

        return List.generate(
          count,
          (_) => normalizedProducts[random.nextInt(normalizedProducts.length)],
        );
      } catch (e) {
        throw FormatException("Invalid JSON format: $e");
      }
    } else {
      throw Exception('Failed to load products. Response: ${response.body}');
    }
  }

  static Future<List<String>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/products/categories'));
    if (response.statusCode == 200) {
      final categories = json.decode(response.body) as List<dynamic>;
      return categories.cast<String>();
    } else {
      throw Exception('Failed to fetch categories');
    }
  }

  static Future<Map<String, dynamic>> fetchProductDetails() async {
    try {
      // Generate a random number between 1 and 40
      final randomProductId = Random().nextInt(40) + 1;

      // Fetch the product details using the random product ID
      final response =
          await http.get(Uri.parse('$baseUrl/products/$randomProductId'));

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load product details');
      }
    } catch (e) {
      return {
        'title': 'Healthy Taco Salad',
        'description':
            'This Healthy Taco Salad is the universal delight of taco night',
        'price': '10.99',
        // 'image': 'assets/images/taco_salad.jpg',
      };
    }
  }

  static Future<List<dynamic>> getFavoriteProducts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteIds = prefs.getStringList('favorite_products');

    if (favoriteIds == null || favoriteIds.isEmpty) {
      return [];
    }

    final List<dynamic> favoriteProducts = [];
    for (String id in favoriteIds) {
      final response = await http.get(Uri.parse('$baseUrl/products/$id'));

      if (response.statusCode == 200) {
        try {
          if (response.body.isNotEmpty) {
            favoriteProducts.add(json.decode(response.body));
          } else {
            print('Empty response for product ID: $id');
          }
        } catch (e) {
          print('Error decoding product $id: $e');
        }
      } else {
        print(
            'Failed to load product ID: $id. Status code: ${response.statusCode}');
      }
    }
    return favoriteProducts;
  }

  // **Helper Method: Save Favorite Product IDs**
  static Future<void> toggleFavoriteProduct(String productId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteIds = prefs.getStringList('favorite_products') ?? [];

    if (favoriteIds.contains(productId)) {
      favoriteIds.remove(productId.toString());
    } else {
      favoriteIds.add(productId.toString());
    }

    await prefs.setStringList('favorite_products', favoriteIds);
  }
}
