import 'dart:convert';
import 'package:http/http.dart' as http;

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
}
