import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/helper/constance.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/services/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserHomeScreen extends StatefulWidget {
  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  int _tabBarIndex = 0;

  int _bottomBarIndex = 0;

  final _store = Store();

  late List<Product> _products;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

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
              onTap: (value) async {
                if (value == 2) {
                  /* SharedPreferences pref =
                  await SharedPreferences.getInstance();
                  pref.clear();
                  await _auth.signOut();
                  Navigator.popAndPushNamed(context, LoginScreen.id);*/
                }
                setState(() {
                  _bottomBarIndex = value;
                });
              },
              items: [
                BottomNavigationBarItem(

                    title: Text('Home'), icon: Icon(Icons.home)),
                BottomNavigationBarItem(
                    title: Text('Cart'), icon: Icon(Icons.shopping_cart),
                ),
                BottomNavigationBarItem(
                    title: Text('Sign Out'), icon: Icon(Icons.close)),
              ],
            ),
            appBar: AppBar(
              toolbarHeight: 70,
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
                  TabText('Primer', 0),
                  TabText('Mascara', 1),
                  TabText('Concealer', 2),
                  TabText('Eyeshadow', 3),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                ProductView("Primer"),
                ProductView("Mascara"),
                ProductView("Concealer"),
                ProductView("Eyeshadow"),
              ],
            ),
          ),

        ),
        Material(
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
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Pacifico',
                      color: Colors.pink.shade300,
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, CartScreen.id);
                      },
                      child: Icon(
                        Icons.shopping_cart,
                        color: TealColor,
                      ))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  //////////////////////////////////////////////////////////////////
  Widget ProductView(String catogry) {
    return StreamBuilder<QuerySnapshot>(
      stream: _store.loadProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> _products = [];

          for (var doc in snapshot.data!.docs) {
            if (Product.fromFirestore(doc).pCategory == catogry) {
              _products.add(Product.fromFirestore(doc));
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
                  onTap: (){
                    Navigator.pushNamed(context, "ProductInfo",arguments: _products[index]);
                  },
                  child: Stack(children: <Widget>[
                    Positioned(
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          border: Border.all(
                            width: 2.5,
                            color: Colors.pink.shade200,
                          ),
                          // color:RosyBrownColor,
                          color: Colors.pink.shade200,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image(
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              _products[index].pImageUrl!,
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
                            padding:
                                EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "catogry: ${_products[index].pCategory!}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "name: ${_products[index].pName!}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "price: ${_products[index].pPrice!}\$",
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
            itemCount: _products.length,
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

  ///////////////////////////////////////////////////////////////////
  Widget TabText(String text, int index) {
    return Text(
      text,
      style: TextStyle(
        overflow: TextOverflow.ellipsis,
        color: _tabBarIndex == index ? Teal2Color : MiddleBlueGreenColor,
        fontSize: _tabBarIndex == index ? 22 : 17,
      ),
    );
  }
}
