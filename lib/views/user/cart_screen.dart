import 'package:ecommerce_app/helper/sizedConfig.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/viewsModel/model_view_cart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<Product> products = Provider.of<CartItem>(context).products;
   // Product? product = ModalRoute.of(context)!.settings.arguments as Product?;

    return Scaffold(
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          if(products.isNotEmpty) {
            print("secussful");
            return Card(
              margin: EdgeInsets.only(
                top: SizeConfig.defaultSize! * 1,
                right: SizeConfig.defaultSize! * 1,
                left: SizeConfig.defaultSize! * 1,
              ),
             // color: PigPinkColor,

              child: Container(
                padding: EdgeInsets.all(SizeConfig.defaultSize! * 8),
                height: SizeConfig.defaultSize! * 15,
                child: Row(
                  children: [
                    Center(child: Text(products[index].pName!,style: TextStyle(color: Colors.black,fontSize: 20),),),
                   /* Expanded(flex: 1,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(products[index].pImageUrl!),
                      ),),*/
                    /*Expanded(flex: 3, child: Column(
                      children: [
                        Text(products[index].pName!,style: TextStyle(color: Colors.black,fontSize: 20),),
                      ],
                    ),),*/
                  ],
                ),
              ),
            );

          }else{
            print("errrotttttttttttttttttttttttt");
          return Card(child: Text("error"),);

          }
        },
      ),
    );
  }
}
