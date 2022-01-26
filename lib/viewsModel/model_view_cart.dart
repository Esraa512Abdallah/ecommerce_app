import 'package:ecommerce_app/models/product.dart';
import 'package:flutter/material.dart';

class CartItem extends ChangeNotifier{

  List<Product> products = [] ;

   AddProduct( Product product){

     products.add(product);
     notifyListeners();

   }
   DeleteProduct(Product product){

     products.remove(product);
     notifyListeners();
   }

}