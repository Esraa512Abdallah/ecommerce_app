import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/helper/constance.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/services/storage.dart';
import 'package:ecommerce_app/viewsModel/model_view_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/views/user/cart_screen.dart';
class ProductInfo extends StatefulWidget {
  const ProductInfo({Key? key}) : super(key: key);

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  late final Store _store;

  String? firstHalf;
  String? secondHalf;
  double? rate;


  bool flag = true;

  @override
  void initState() {
    super.initState();

    _store = Store();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Product? product = ModalRoute.of(context)!.settings.arguments as Product?;
    if (product!.pDescription!.length > 50) {
      firstHalf = product.pDescription!.substring(0, 50);
      secondHalf =
          product.pDescription!.substring(50, product.pDescription!.length);
    } else {
      firstHalf = product.pDescription!;
      secondHalf = "";
    }
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Container(
                  padding: EdgeInsets.only(bottom: 60),
                  height: MediaQuery.of(context).size.height * .8,
                  child: Center(
                    child: CachedNetworkImage(
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(
                        color: Colors.grey,
                      ),
                      imageUrl: product.pImageUrl.toString(),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 30, 20, 0),
                child: Container(
                  height: MediaQuery.of(context).size.height * .1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: TealColor,
                            size: 35,
                          )),
                      GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, "CartScreen",arguments: product);
                          },
                          child: Icon(
                            Icons.shopping_cart,
                            color: TealColor,
                            size: 35,
                          ))
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                child: Column(
                  children: <Widget>[
                    Opacity(
                      child: Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * .4,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "${product.pCategory!} catogry",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${product.pName!} type",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '\$${product.pPrice!}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                child: secondHalf!.isEmpty
                                    ? Text(firstHalf!)
                                    : Column(
                                        children: <Widget>[
                                          Text(
                                            flag
                                                ? (firstHalf! + "...")
                                                : (firstHalf! + secondHalf!),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                          InkWell(
                                            child: new Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: <Widget>[
                                                new Text(
                                                  flag
                                                      ? "show more"
                                                      : "show less",
                                                  style: new TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20),
                                                ),
                                              ],
                                            ),
                                            onTap: () {
                                              setState(() {
                                                flag = !flag;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  RatingBar.builder(
                                    initialRating: 3,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 4.0),
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.pink,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print("rating value : $rating");
                                      setState(() {
                                        rate = rating;

                                      });
                                    },
                                  ),
                                ],
                              ),

                            ],
                          ),
                        ),
                      ),
                      opacity: .5,
                    ),
                    ButtonTheme(
                      minWidth: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .08,
                      child: Builder(
                        builder: (context) => RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10))),
                                   color: Colors.pink.shade200,
                                 onPressed: () {

                                CartItem cartItem = Provider.of<CartItem>(context, listen: false);

                                  //setState(() {
                                 //   product.Prate=rate;
                                  //});


                                // bool exist = false;
                                // var productsInCart = cartItem.products;
                                /* for (var productInCart in productsInCart) {
                                  if (productInCart.pName == product.pName) {
                                    exist = true;
                                  }
                                }
                                if (exist) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('you\'ve added this item before'),
                                  ));
                                } else {*/
                                cartItem.AddProduct(product);
                                Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Added to Cart'),
                                ));
                                // }
                                },








                          child: Text(
                            'Add to Cart'.toUpperCase(),
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
          ),
        ],
      ),
    );

  }
}

