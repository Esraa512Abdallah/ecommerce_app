import 'package:ecommerce_app/views/admin/add_product.dart';
import 'package:ecommerce_app/views/admin/admin_home_screen.dart';
import 'package:ecommerce_app/views/admin/edit_product.dart';
import 'package:ecommerce_app/views/admin/manage_product.dart';
import 'package:ecommerce_app/views/admin/order_details_screen.dart';
import 'package:ecommerce_app/views/admin/order_screen.dart';
import 'package:ecommerce_app/views/user/cart_screen.dart';
import 'package:ecommerce_app/views/user/product_info_screen.dart';
import 'package:ecommerce_app/views/user/user_home_screen.dart';
import 'package:ecommerce_app/views/login_screen.dart';
import 'package:ecommerce_app/views/signup_screen.dart';
import 'package:ecommerce_app/viewsModel/model_view_cart.dart';
import 'package:ecommerce_app/viewsModel/model_view_favorite.dart';
import 'package:ecommerce_app/viewsModel/model_view_hud.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ModelHud>(
          create: (context) => ModelHud(),
        ),
        ChangeNotifierProvider<CartItem>(
          create: (context) => CartItem(),
        ),
        ChangeNotifierProvider<FavoriteItem>(
          create: (context) => FavoriteItem(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "UserHomeScreen",
        routes: {
          "LoginScreen ": (context) => LoginScreen(),
          "SignUpScreen": (context) => SignUpScreen(),
          "AdminHomeScreen": (context) => AdminHomeScreen(),
          "AddProductScreen ": (context) => AddProductScreen(),
          "EditProduct": (context) => EditProduct(),
          "ManageProducts": (context) => ManageProducts(),
          "UserHomeScreen": (context) => UserHomeScreen(),
          "ProductInfo": (context) => ProductInfo(),
          "CartScreen":(context)=>CartScreen(),
          "OrderScreen":(context)=>OrderScreen(),
          "OrderDetailsScreen":(context)=>OrderDetailsScreen(),
        },
      ),
    );
  }
}
