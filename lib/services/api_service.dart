import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';

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
}
