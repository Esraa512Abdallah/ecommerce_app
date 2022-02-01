import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/helper/constance.dart';
import 'package:ecommerce_app/helper/sizedConfig.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/services/storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({Key? key}) : super(key: key);

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  int _orderValue = 1;

  @override
  Widget build(BuildContext context) {
    String? documentId = ModalRoute.of(context)!.settings.arguments as String?;

    final _store = Store();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "OrderScreen");
            },
            child: Icon(
              Icons.arrow_back,
              color: TealColor,
              size: 35,
            )),
        title: Text(
          'Order Details',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pacifico',
            color: TealColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: _store.loadOrderDertails(documentId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Product> _products = [];

                for (var doc in snapshot.data!.docs) {
                  _products.add(Product.fromFirestore(doc));
                }
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          padding: EdgeInsets.only(
                            top: SizeConfig.defaultSize! * 1.2,
                            bottom: SizeConfig.defaultSize! * 1,
                            left: SizeConfig.defaultSize! * .5,
                            right: SizeConfig.defaultSize! * .5,
                          ),
                          itemCount: _products.length,
                          itemBuilder: (context, index) {
                            if (_orderValue == 0) {
                              return Container();
                            } else {
                              return GestureDetector(
                                onTap: () {},
                                child: Container(
                                  height: SizeConfig.screenHeight! * .3,
                                  child: Card(
                                    color: Colors.grey[100],
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Container(
                                      padding: EdgeInsets.only(
                                        left: SizeConfig.defaultSize! * 2,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Product Name: ",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                " ${_products[index].pName}",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 20),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: SizeConfig.defaultSize! * 1,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Product Category: ",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${_products[index].pCategory}",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 20),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: SizeConfig.defaultSize! * 1,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                "Product Price: ",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                "${_products[index].pPrice}",
                                                style: TextStyle(
                                                    color: Colors.black54,
                                                    fontSize: 20),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }
                          }),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: SizeConfig.defaultSize! * 1),
                      child: Row(
                        children: [
                          ButtonTheme(
                            minWidth: MediaQuery.of(context).size.width * .45,
                            height: MediaQuery.of(context).size.height * .08,
                            child: Builder(
                              builder: (context) => RaisedButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30)),
                                ),
                                color: Colors.pink.shade200,
                                onPressed: () {
                                  _store.deleteOrder(documentId!);
                                  setState(() {
                                    _orderValue = 0;
                                  });
                                },
                                child: Text(
                                  'Delete'.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: TealColor),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: SizeConfig.defaultSize! * 1,
                          ),
                          ButtonTheme(
                            minWidth: MediaQuery.of(context).size.width * .45,
                            height: MediaQuery.of(context).size.height * .08,
                            child: Builder(
                              builder: (context) => RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                )),
                                color: Colors.pink.shade200,
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Confirm'.toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: TealColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(
                  child: Text("loading order details.."),
                );
              }
            }),
      ),
    );
  }
}
