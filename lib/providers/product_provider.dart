import 'package:flutter/material.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  List<dynamic> _products = [];
  List<String> _categories = [];
  String _selectedCategory = 'electronics';
  bool _isLoadingProducts = false;
  bool _isLoadingCategories = false;
  String? _errorMessage;

  List<dynamic> get products => _products;
  List<String> get categories => _categories;
  String get selectedCategory => _selectedCategory;
  bool get isLoadingProducts => _isLoadingProducts;
  bool get isLoadingCategories => _isLoadingCategories;
  String? get errorMessage => _errorMessage;

  Future<void> fetchProducts() async {
    _isLoadingProducts = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _products = await ApiService.getRandomProducts(5);
    } catch (e) {
      _errorMessage = "Failed to load products: $e";
      // Fallback dummy data
      _products = [
        {
          'id': 1,
          'title': 'Dummy Product 1',
          'price': 20.00,
          'category': 'Category A',
          'description': 'This is a dummy product.',
          'image': 'dummy'
        },
        {
          'id': 2,
          'title': 'Dummy Product 2',
          'price': 30.00,
          'category': 'Category B',
          'description': 'This is another dummy product.',
          'image': 'dummy'
        },
        {
          'id': 3,
          'title': 'Dummy Product 3',
          'price': 40.00,
          'category': 'Category C',
          'description': 'Dummy product for fallback.',
          'image': 'dummy'
        },
        {
          'id': 4,
          'title': 'Dummy Product 4',
          'price': 50.00,
          'category': 'Category D',
          'description': 'Fallback dummy product.',
          'image': 'dummy'
        },
        {
          'id': 5,
          'title': 'Dummy Product 5',
          'price': 60.00,
          'category': 'Category E',
          'description': 'More dummy products.',
          'image': 'dummy'
        }
      ];
    } finally {
      _isLoadingProducts = false;
      notifyListeners();
    }
  }

  Future<void> fetchCategories() async {
    _isLoadingCategories = true;
    notifyListeners();

    try {
      _categories = await ApiService.getCategories();
      if (_categories.isNotEmpty && !_categories.contains(_selectedCategory)) {
        _selectedCategory = _categories.first;
      }
    } catch (e) {
      _categories = [
        "electronics",
        "jewelery",
        "men's clothing",
        "women's clothing"
      ];
      _selectedCategory = _categories.first;
    } finally {
      _isLoadingCategories = false;
      notifyListeners();
    }
  }

  void setSelectedCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
