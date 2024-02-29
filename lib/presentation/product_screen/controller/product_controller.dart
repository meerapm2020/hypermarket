import 'package:flutter/material.dart';
import 'package:hypermarket_addproduct/model/product_model.dart';

class ProductController with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;
  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }

  void updateProduct(int index, Product product) {
    if (index >= 0 && index < _products.length) {
      _products[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(int index) {
    if (index >= 0 && index < _products.length) {
      _products.removeAt(index);
      notifyListeners();
    }
  }
}
