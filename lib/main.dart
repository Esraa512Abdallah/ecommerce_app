import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ecommerce_app/views/admin/add_product.dart';
import 'package:ecommerce_app/views/admin/admin_home_screen.dart';
import 'package:ecommerce_app/views/admin/edit_product.dart';
import 'package:ecommerce_app/views/admin/manage_product.dart';
import 'package:ecommerce_app/views/admin/order_details_screen.dart';
import 'package:ecommerce_app/views/admin/order_screen.dart';
import 'package:ecommerce_app/views/login_screen.dart';
import 'package:ecommerce_app/views/signup_screen.dart';
import 'package:ecommerce_app/views/user/cart_screen.dart';
import 'package:ecommerce_app/views/user/product_info_screen.dart';
import 'package:ecommerce_app/views/user/user_home_screen.dart';
import 'package:ecommerce_app/viewsModel/model_view_cart.dart';
import 'package:ecommerce_app/viewsModel/model_view_favorite.dart';
import 'package:ecommerce_app/viewsModel/model_view_hud.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'helper/app_theme.dart';
import 'helper/constance.dart';

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
        home: AnimatedSplashScreen(
          splashIconSize: 500,
          duration: 5000,
          splash: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/makeup1.jpg",
                ),
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(top: 100),
              child: Text(
                "Eyeliner Store",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                  fontFamily: 'Pacifico',
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          nextScreen: UserHomeScreen(),
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.grey[200]!,
        ),
        routes: {
          "LoginScreen": (context) => LoginScreen(),
          "SignUpScreen": (context) => SignUpScreen(),
          "AdminHomeScreen": (context) => AdminHomeScreen(),
          "AddProductScreen": (context) => AddProductScreen(),
          "EditProduct": (context) => EditProduct(),
          "ManageProducts": (context) => ManageProducts(),
          "UserHomeScreen": (context) => UserHomeScreen(),
          "ProductInfo": (context) => ProductInfo(),
          "CartScreen": (context) => CartScreen(),
          "OrderScreen": (context) => OrderScreen(),
          "OrderDetailsScreen": (context) => OrderDetailsScreen(),
        },

        theme: ThemeData(

          appBarTheme: AppBarTheme(

            color: Colors.pink.shade200,
            centerTitle: true,
            elevation: 0.0,
            actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
            titleTextStyle: TextStyle(
                color: Colors.white,//HexColor('#FFFFFF'),
                fontSize: 15.0,
                fontFamily: 'Poppins-Regular'),
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.grey[200],
                statusBarIconBrightness: Brightness.light),
          ),

          accentColor: Colors.pink.shade500,
          //fontFamily: "Pacifico",




          cardColor: Colors.white,
            progressIndicatorTheme:ProgressIndicatorThemeData(
              color: Colors.grey
            ) ,



        ),
      ),

    );
  }
}


