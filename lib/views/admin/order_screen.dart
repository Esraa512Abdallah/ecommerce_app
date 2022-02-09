import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/helper/constance.dart';
import 'package:ecommerce_app/helper/sizedConfig.dart';
import 'package:ecommerce_app/models/order.dart';
import 'package:ecommerce_app/services/storage.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final Store _store = Store();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "AdminHomeScreen");
            },
            child: Icon(
              Icons.arrow_back,
              color: primaryTealColor,
              size: 35,
            )),
        backgroundColor: Colors.white,
        title: Text(
          'Orders',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pacifico',
            color: primaryTealColor,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Order> orders = [];

            for (var doc in snapshot.data!.docs) {
              orders.add(Order.fromFirebase(doc));
            }

            return ListView.builder(
                padding: EdgeInsets.only(
                  top: SizeConfig.defaultSize! * 1.2,
                  bottom: SizeConfig.defaultSize! * 1,
                  left: SizeConfig.defaultSize! * .5,
                  right: SizeConfig.defaultSize! * .5,
                ),
                itemCount: orders.length,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "OrderDetailsScreen",
                            arguments: orders[index].docId);
                      },
                      child: Container(
                        height: SizeConfig.screenHeight! * .15,
                        child: Card(
                          color: Colors.grey[100],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            padding: EdgeInsets.only(
                              left: SizeConfig.defaultSize! * 4.5,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Total Price of order:",
                                      style: TextStyle(
                                          color: primaryPinkColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "  \$ ${orders[index].TotalPrice}",
                                      style: TextStyle(
                                          color: primaryTealColor, fontSize: 20),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: SizeConfig.defaultSize! * 1,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "User Address:  ",
                                      style: TextStyle(
                                          color: primaryPinkColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${orders[index].Address}",
                                      style: TextStyle(
                                          color: primaryTealColor, fontSize: 20),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ));
          } else {
            return Center(
              child: Text("there is no orders"),
            );
          }
        },
      ),
    );
  }
}
