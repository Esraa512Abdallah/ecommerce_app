import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/helper/constance.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/services/storage.dart';
import 'package:ecommerce_app/viewsModel/model_view_cart.dart';
import 'package:ecommerce_app/viewsModel/model_view_favorite.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  const ProductInfo({Key? key}) : super(key: key);

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  late final Store _store;

  String? firstHalf;
  String? secondHalf;
  double rate = 0;

  bool flag = true;
  int favor = 0;

  var _quantity = 0;

  @override
  void initState() {
    super.initState();

    _store = Store();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    int cartItemLenght = Provider.of<CartItem>(context, listen: false).products.length;

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
                  padding: EdgeInsets.only(bottom: 90),
                  height: MediaQuery.of(context).size.height * 1.5,
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
                            Icons.arrow_back,
                            color: primaryTealColor,
                            size: 35,
                          )),
                      Padding(
                        padding: const EdgeInsets.only(right: 12.0),
                        child: Badge(

                          badgeColor: Colors.white,
                          badgeContent: Text("$cartItemLenght",style:TextStyle( color:primaryPinkColor)),
                          child: Icon(

                            Icons.shopping_cart,
                            size: 35,
                            color: primaryTealColor,
                          ),
                        ),
                      ),
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
                        height: MediaQuery.of(context).size.height * .50,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ListView(
                            children: [
                              Column(
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
                                                    : (firstHalf! +
                                                        secondHalf!),
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
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20,
                                                      ),
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
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RatingBar.builder(
                                        initialRating: 0,
                                        minRating: 1,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemPadding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
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
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ClipOval(
                                        child: Material(
                                          color: FeildfillColor,
                                          child: GestureDetector(
                                            onTap: add,
                                            child: SizedBox(
                                              child: Icon(Icons.add),
                                              height: 32,
                                              width: 32,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        _quantity.toString(),
                                        style: TextStyle(fontSize: 60),
                                      ),
                                      ClipOval(
                                        child: Material(
                                          color: FeildfillColor,
                                          child: GestureDetector(
                                            onTap: subtract,
                                            child: SizedBox(
                                              child: Icon(Icons.remove),
                                              height: 32,
                                              width: 32,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      opacity: .5,
                    ),
                    Row(
                      children: [

                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * .2,
                          height: MediaQuery.of(context).size.height * .08,
                          child: Builder(
                            builder: (context) => RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                              ),
                              color: Colors.grey[300],
                              onPressed: () {
                                FavoriteItem favoriteItem =
                                    Provider.of<FavoriteItem>(context,
                                        listen: false);

                                bool exsit = false;
                                var productsInFavorite = favoriteItem.products;

                                for (var productInCart in productsInFavorite) {
                                  if (productInCart.pName == product.pName) {
                                    exsit = true;
                                  }
                                }
                                if (exsit) {

                                  Fluttertoast.showToast(
                                    msg: 'you\'ve added this item before',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 12,
                                    backgroundColor: Colors.grey[200],
                                    textColor: primaryPinkColor,
                                    webPosition:"right" ,
                                    fontSize: 20.0,

                                  );

                                } else {
                                  favoriteItem.AddProductToFavorite(product);
                                  product.Prate = rate;
                                  product.Pquantity = _quantity;

                                  Fluttertoast.showToast(
                                    msg: "  Added to favorite  ",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 12,
                                    backgroundColor: Colors.grey[200],
                                    textColor: primaryPinkColor,
                                    webPosition:"right" ,
                                    fontSize: 20.0,

                                  );

                                }

                                setState(() {
                                  favor = 1;
                                  product.Pfavorite = 1;
                                });
                              },
                              child: (favor == 1)
                                  ? Icon(
                                      Icons.favorite,
                                      color: primaryPinkColor,
                                      size: 35,
                                    )
                                  : (favor == 0)
                                      ? Icon(
                                          Icons.favorite_border,
                                          color: primaryPinkColor,
                                          size: 35,
                                        )
                                      : Icon(
                                          Icons.favorite_border,
                                          color: primaryPinkColor,
                                          size: 35,
                                        ),
                            ),
                          ),
                        ),
                        ButtonTheme(
                          minWidth: MediaQuery.of(context).size.width * .8,
                          height: MediaQuery.of(context).size.height * .08,
                          child: Builder(
                            builder: (context) => RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              )),
                              color: primaryPinkColor,
                              onPressed: () {
                                CartItem cartItem = Provider.of<CartItem>(
                                    context,
                                    listen: false);

                                bool exsit = false;
                                var productsInCart = cartItem.products;

                                for (var productInCart in productsInCart) {
                                  if (productInCart.pName == product.pName) {
                                    exsit = true;
                                  }
                                }
                                if (exsit) {
                                  Fluttertoast.showToast(

                                    msg: 'you\'ve added this item before',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 12,
                                    backgroundColor: Colors.grey[200],
                                    textColor: primaryPinkColor,
                                    webPosition:"right" ,
                                    fontSize: 20.0,
                                  );

                                } else {
                                  cartItem.AddProductToCart(product);
                                  product.Prate = rate;
                                  product.Pquantity = _quantity;

                                  Fluttertoast.showToast(
                                    msg:  '     Added to Cart     ',
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 12,
                                    backgroundColor: Colors.grey[200],
                                    textColor: primaryPinkColor,
                                     webPosition:"right" ,
                                    fontSize: 20.0,
                                  );
                                 /* Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Added to Cart'),
                                  )*/
                                 // );
                                }
                              },
                              child: Text(
                                'Add to Cart'.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: primaryTealColor),
                              ),
                            ),
                          ),
                        ),
                      ],
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

  subtract() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        print(_quantity);
      });
    }
  }

  add() {
    setState(() {
      _quantity++;
      print(_quantity);
    });
  }
}
