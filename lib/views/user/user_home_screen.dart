
/*
import 'package:flutter/material.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}
*/

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/helper/constance.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/services/auth.dart';
import 'package:ecommerce_app/services/storage.dart';
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

  // FirebaseUser _loggedUser;
  int _tabBarIndex = 0;
  int _bottomBarIndex = 0;
  final _store = Store();
  List<Product> _products = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 4,
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: Colors.grey,
              currentIndex: _bottomBarIndex,
              fixedColor: PinkColor,

              items: [
                BottomNavigationBarItem(
                    title: Text('home'), icon: Icon(Icons.home)),
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
              bottom: TabBar(
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
                      fontSize: _tabBarIndex == 0 ? 20 : 18,
                    ),
                  ),
                  Text(
                    'Eyeshadow',
                    style: TextStyle(
                      color: _tabBarIndex == 1 ? TealColor : Teal2Color,
                      fontSize: _tabBarIndex == 1 ? 20 : 18,
                    ),
                  ),
                  Text(
                    'Mascara',
                    style: TextStyle(
                      color: _tabBarIndex == 2 ? TealColor : Teal2Color,
                      fontSize: _tabBarIndex == 2 ? 20 : 18,
                    ),
                  ),
                  Text(
                    'Concealer',
                    style: TextStyle(
                      color: _tabBarIndex == 3 ? TealColor : Teal2Color,
                      fontSize: _tabBarIndex == 3 ? 20 : 18,
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                Container(),
                Container(),
                Container(),
                Container(),
                //jacketView(),
                // ProductsView(kTrousers, _products),
                //ProductsView(kShoes, _products),
                //ProductsView(kTshirts, _products),
              ],
            ),
          ),
        ),
        Material(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height * .1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Eyeliner Store'.toUpperCase(),
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,fontFamily: ""),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "CartScreen");
                      },
                      child: Icon(Icons.shopping_cart))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
  /*@override
  void initState() {
    getCurrenUser();
  }*/
/*
  getCurrenUser() async {
    _loggedUser = await _auth.getUser();
  }*/

  /*
  Widget jacketView() {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = [];
          for (var doc in snapshot.data.documents) {
            var data = doc.data;
            products.add(Product(
                pId: doc.documentID,
                pPrice: data[kProductPrice],
                pName: data[kProductName],
                pDescription: data[kProductDescription],
                pLocation: data[kProductLocation],
                pCategory: data[kProductCategory]));
          }
          _products = [...products];
          products.clear();
          products = getProductByCategory(kJackets, _products);
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: .8,
            ),
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, ProductInfo.id,
                      arguments: products[index]);
                },
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                      child: Image(
                        fit: BoxFit.fill,
                        image: AssetImage(products[index].pLocation),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Opacity(
                        opacity: .6,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 60,
                          color: Colors.white,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  products[index].pName,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text('\$ ${products[index].pPrice}')
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            itemCount: products.length,
          );
        } else {
          return Center(child: Text('Loading...'));
        }
      },
    );
  }*/
