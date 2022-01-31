import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

class FavoriteItem extends ChangeNotifier {
  List<Product> products = [];

  AddProductToFavorite(Product product) {
    products.add(product);
    notifyListeners();
  }

  DeleteProductFromFavorite(Product product) {
    products.remove(product);
    notifyListeners();
  }
}
