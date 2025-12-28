import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _errorMessage;
  final ApiService _apiService = ApiService();

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login(String username, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _apiService.login({
        'username': username,
        'password': password,
      });

      final token = response['token'] ?? '';
      if (token.isEmpty) {
        throw Exception('Token is missing in the response');
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('username', username);

      return true;
    } catch (e) {
      _errorMessage = 'Failed to log in: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> signup(String username, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final userData = {
        'email': email,
        'username': username,
        'password': password,
        'name': {'firstname': 'John', 'lastname': 'Doe'},
        'address': {
          'city': 'Kilcoole',
          'street': '7835 new road',
          'number': 3,
          'zipcode': '12926-3874',
        },
        'phone': '1-570-236-7033',
      };

      final response = await _apiService.signup(userData);

      final savedUsername = response['username'] ?? 'Unknown';
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('username', savedUsername);

      return true;
    } catch (e) {
      _errorMessage = 'Failed to create account: $e';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
