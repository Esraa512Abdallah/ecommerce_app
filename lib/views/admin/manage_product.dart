import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/helper/constance.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/services/storage.dart';
import 'package:ecommerce_app/views/widgets/custom_mypopupmenuitem.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageProducts extends StatefulWidget {
  //static const String id = "ManageProducts";
  /*
  static Route get route => MaterialPageRoute<void>(
    builder: (context) => ManageProducts(),
  );
*/
  static Route get route => MaterialPageRoute<void>(
      builder: (context) => ManageProducts(),
  );

  const ManageProducts({Key? key}) : super(key: key);

  @override
  _ManageProductsState createState() => _ManageProductsState();
}

class _ManageProductsState extends State<ManageProducts> {
  late final Store _store;

  @override
  void initState() {
    _store = Store();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];

            for (var doc in snapshot.data!.docs) {
              products.add(Product.fromFirestore(doc));
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
                    onTapUp: (details) {
                      double dx = details.globalPosition.dx;
                      double dy = details.globalPosition.dy;
                      double dx2 = MediaQuery.of(context).size.width - dx;
                      double dy2 = MediaQuery.of(context).size.height - dy;

                      showMenu(
                          context: context,
                          position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
                          items: [
                            MyPopupMenuItem(
                              child: Text("Edit"),
                              onClick: () {
                                // debugPrint(products[index].);

                               Navigator.of(context).pushReplacementNamed(
                                    "EditProduct",
                                    arguments: products[index]
                               );

                              },
                            ),
                            MyPopupMenuItem(
                              child: Text("Delete"),
                              onClick: () {
                                Store().deleteProduct(products[index].pId!);
                              },
                            ),
                          ]);
                    },
                    child: Stack(children: <Widget>[
                      Positioned(
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                              width: 2.5,
                              color: RosyBrownColor,
                            ),
                            color:RosyBrownColor,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image(
                              height: double.infinity,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                products[index].pImageUrl!,
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "name: ${products[index].pName!}",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "price: ${products[index].pPrice!}\$",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
      ),
    );
  }
}
