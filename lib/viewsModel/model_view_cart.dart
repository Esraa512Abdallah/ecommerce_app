import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

class CartItem extends ChangeNotifier {
  List<Product> products = [];

  AddProductToCart(Product product) {
    products.add(product);
    notifyListeners();
  }

  DeleteProductFromCart(Product product) {
    products.remove(product);
    notifyListeners();
  }
}
