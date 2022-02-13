import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/helper/constance.dart';
import 'package:ecommerce_app/helper/sizedConfig.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/services/storage.dart';
import 'package:ecommerce_app/views/widgets/custom_mypopupmenuitem.dart';
import 'package:ecommerce_app/viewsModel/model_view_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var SCH = SizeConfig.screenHeight!;
    List<Product> products = Provider.of<CartItem>(context).products;

    return

      Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(
                  top: SizeConfig.defaultSize! * 1.2,
                  bottom: SizeConfig.defaultSize! * 1,
                  left: SizeConfig.defaultSize! * .5,
                  right: SizeConfig.defaultSize! * .5,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  if (products.isNotEmpty) {
                    return Card(

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              height: SizeConfig.screenHeight! / 4,
                              margin: EdgeInsets.only(
                                  left: 10, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              child: CachedNetworkImage(
                                placeholder: (context , url){
                                  return Center(child: CircularProgressIndicator(
                                    color: Colors.grey,
                                  ));
                                },
                                height: 100,
                                imageUrl: "${products[index].pImageUrl}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: SizeConfig.screenHeight! / 3,
                              padding: EdgeInsets.only(
                                left: SizeConfig.defaultSize! * 1.5,
                                top: SizeConfig.defaultSize! * 4,
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                  Padding(
                                    padding: const EdgeInsets.only(right: 25),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Container(

                                          child: MaterialButton(
                                            onPressed: (){
                                              Navigator.pop(context);
                                              Navigator.pushNamed(context, "ProductInfo",
                                                  arguments: products[index]);

                                              Provider.of<CartItem>(context, listen: false)
                                                  .DeleteProductFromCart(products[index]);
                                            },
                                            child: Icon(
                                              Icons.edit,
                                              color: primaryPinkColor,
                                              size: 35,
                                            ),
                                          ),
                                          width: 35,
                                        ),

                                        SizedBox(width: 7,),
                                        Container(

                                          child: MaterialButton(
                                            onPressed: (){
                                              // Navigator.pop(context);
                                              Provider.of<CartItem>(context, listen: false)
                                                  .DeleteProductFromCart(products[index]);
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: primaryPinkColor,
                                              size: 35,
                                            ),
                                          ),
                                          width: 35,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.defaultSize! * .8,
                                  ),
                                  Text(
                                    products[index].pName!,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: primaryTealColor,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.defaultSize! * 1.2,
                                  ),
                                  Text(
                                    "${products[index].pCategory!} ",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500,
                                        color: Teal2Color,
                                        overflow: TextOverflow.ellipsis),
                                  ),
                                  SizedBox(
                                    height: SizeConfig.defaultSize! * 1.2,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${products[index].pPrice!} \$",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Teal2Color,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                      SizedBox(
                                        width: SizeConfig.defaultSize! * 10,
                                      ),
                                      Text(
                                        "${products[index].Pquantity!.toString()} ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: Teal2Color,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: SizeConfig.defaultSize! * 1.2,
                                  ),
                                  Row(
                                    children: [
                                      Stack(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            size: 55,
                                            color: primaryPinkColor,
                                          ),
                                          Positioned(
                                            left:2,
                                            top: 3,
                                            child: Text(
                                              products[index]
                                                  .Prate
                                                  .toString(),
                                              style: TextStyle(
                                                  color: primaryTealColor,
                                                  fontSize: 40),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: SizeConfig.defaultSize! * 8,
                                      ),
                                      Container(
                                        child: (products[index].Pfavorite ==
                                            1)
                                            ? Icon(
                                          Icons.favorite,
                                          color: primaryPinkColor,
                                          size: 35,
                                        )
                                            : (products[index].Pfavorite == 0)
                                            ? Icon(
                                          Icons.favorite_border,
                                          color:
                                          primaryPinkColor,
                                          size: 35,
                                        )
                                            : Icon(
                                          Icons.favorite_border,
                                          color:
                                          primaryPinkColor,
                                          size: 35,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container(
                      height: SCH - SizeConfig.screenHeight! * .08 - 50,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              "Cart is empty",
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 60, left: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total price",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    "\$ ${getTotallPrice(products).toString()}",
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .08,
              child: Builder(
                builder: (context) => RaisedButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20))),
                  color: primaryPinkColor,
                  onPressed: () {
                    showCustomDialog(context, products);
                  },
                  child: Text(
                    'order'.toUpperCase(),
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
      );

  }

  void showCustomDialog(context, products) async {
    var address;
    var price = getTotallPrice(products);
    AlertDialog alertDialog = AlertDialog(
      actions: <Widget>[
        Center(
          child: MaterialButton(
            onPressed: () {
              try {
                Store _store = Store();

                _store.storeOrders(
                    {"TotalPrice": price, "Address": address}, products);


                Fluttertoast.showToast(
                  msg:  'Orderd Successfully',
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 12,
                  backgroundColor: Colors.grey[200],
                  textColor: primaryPinkColor,
                  webPosition:"right" ,
                  fontSize: 20.0,
                );

                Navigator.pop(context);
              } catch (ex) {
                //print(ex.message);
              }
            },
            minWidth: MediaQuery.of(context).size.width * .2,
            height: MediaQuery.of(context).size.height * .05,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            color: primaryPinkColor,
            child: Text('Confirm'),
          ),
        )
      ],
      content: TextField(
        onChanged: (value) {
          address = value;
        },
        decoration: InputDecoration(hintText: 'Enter your Address'),
      ),
    );
    await showDialog(
        context: context,
        builder: (context) {
          return alertDialog;
        });
  }

  getTotallPrice(List<Product> products) {
    var price = 0;
    for (var product in products) {
      price += product.Pquantity! * int.parse(product.pPrice!);
    }
    return price;
  }
}

