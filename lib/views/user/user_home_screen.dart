import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/helper/constance.dart';
import 'package:ecommerce_app/helper/sizedConfig.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/services/auth.dart';
import 'package:ecommerce_app/services/storage.dart';
import 'package:ecommerce_app/views/user/cart_screen.dart';
import 'package:ecommerce_app/views/user/favorite_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserHomeScreen extends StatefulWidget {
  static String id = 'UserHomeScreen';

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final _auth = Auth();

  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  final _store = Store();
  List<Product> _products = [];

  @override
  void initState() {
    // TODO: implement initState
    if (_bottomBarIndex == 3) {
      _auth.signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    int _selectedIndex = 0;
    List<Widget> Screens = [
      TabBarView(
        children: <Widget>[
          ProductView("Primer"),
          ProductView("Eyeshadow"),
          ProductView("Mascara"),
          ProductView("Concealer"),
        ],
      ),
      CartScreen(),
      FavoriteScreen(),
      Container(),
    ];

    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              currentIndex: _bottomBarIndex,
              selectedItemColor: Colors.pink.shade200,
              selectedFontSize: 22,
              selectedIconTheme: IconThemeData(
                size: 35,
              ),
              onTap: (val) {
                setState(() {
                  _bottomBarIndex = val;
                });
              },
              items: [
                BottomNavigationBarItem(
                  title: Text('home'),
                  icon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                    title: Text('cart'), icon: Icon(Icons.shopping_cart)),
                BottomNavigationBarItem(
                    title: Text('favorite'), icon: Icon(Icons.favorite_border)),
                BottomNavigationBarItem(
                    title: Text('sign out'), icon: Icon(Icons.close)),
              ],
            ),
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              bottom: (_bottomBarIndex == 0)
                  ? TabBar(
                      isScrollable: true,
                      indicatorColor: PinkColor,
                      onTap: (value) {
                        setState(() {
                          _tabBarIndex = value;
                        });
                      },
                      tabs: <Widget>[
                        Text(
                          'Primer',
                          style: TextStyle(
                            color: _tabBarIndex == 0 ? TealColor : Teal2Color,
                            fontSize: _tabBarIndex == 0 ? 20 : 16,
                            fontWeight:
                                _tabBarIndex == 0 ? FontWeight.bold : null,
                          ),
                        ),
                        Text(
                          'Eyeshadow',
                          style: TextStyle(
                            color: _tabBarIndex == 1 ? TealColor : Teal2Color,
                            fontSize: _tabBarIndex == 1 ? 20 : 16,
                            fontWeight:
                                _tabBarIndex == 1 ? FontWeight.bold : null,
                          ),
                        ),
                        Text(
                          'Mascara',
                          style: TextStyle(
                            color: _tabBarIndex == 2 ? TealColor : Teal2Color,
                            fontSize: _tabBarIndex == 2 ? 20 : 16,
                            fontWeight:
                                _tabBarIndex == 2 ? FontWeight.bold : null,
                          ),
                        ),
                        Text(
                          'Concealer',
                          style: TextStyle(
                            color: _tabBarIndex == 3 ? TealColor : Teal2Color,
                            fontSize: _tabBarIndex == 3 ? 20 : 16,
                            fontWeight:
                                _tabBarIndex == 3 ? FontWeight.bold : null,
                          ),
                        ),
                      ],
                    )
                  : null,
            ),
            body: Screens[_bottomBarIndex],
          ),
        ),
        (_bottomBarIndex == 0)
            ? Material(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * .1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Eyeliner Store',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Pacifico',
                            color: Colors.pink.shade200,
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, "CartScreen");
                            },
                            child: Icon(
                              Icons.shopping_cart,
                              size: 35,
                              color: TealColor,
                            ))
                      ],
                    ),
                  ),
                ),
              )
            : Material(
                child: Container(
                  height: 85,
                  color: Colors.grey[100],
                ),
              )
      ],
    );
  }

  Widget ProductView(String productCategory) {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product>? products = [];

          for (var doc in snapshot.data!.docs) {
            if (doc["productCategory"] == productCategory) {
              products.add(Product.fromFirestore(doc));
            }
          }
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .73,
            ),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "ProductInfo",
                        arguments: products[index]);
                  },
                  child: Stack(children: <Widget>[
                    Positioned(
                      child: Container(
                        height: SizeConfig.screenHeight! * .8,
                        width: SizeConfig.screenWidth!,
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            width: 2.5,
                            color: Colors.pink.shade100,
                          ),
                          color: Colors.pink.shade100,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              "${products[index].pImageUrl}",
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Opacity(
                        opacity: .6,
                        child: Container(
                          color: Colors.white,
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "catogry: ${products[index].pCategory!}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "name: ${products[index].pName!}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "price: ${products[index].pPrice!}\$",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
              );
            },
            itemCount: products.length,
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Colors.grey[500],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "loading...",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
