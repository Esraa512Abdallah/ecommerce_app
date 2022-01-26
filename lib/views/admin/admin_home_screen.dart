import 'package:ecommerce_app/helper/constance.dart';
import 'package:ecommerce_app/helper/sizedConfig.dart';
import 'package:ecommerce_app/views/admin/edit_product.dart';
import 'package:ecommerce_app/views/login_screen.dart';
import 'package:ecommerce_app/views/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_product.dart';

class AdminHomeScreen  extends StatelessWidget{
  static const String id = 'AdminHomeScreen';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build

    return Scaffold(
      appBar:  AppBar(

        backgroundColor: Teal2Color,
        centerTitle: true,
        title: Text("Admin Home" , style:  TextStyle(
          fontWeight: FontWeight.w500 , fontSize:25 ,color: Colors.white,fontFamily: 'Pacifico'
        ),),


      ),
      body: Container(
        padding: EdgeInsets.only(
            right: SizeConfig.defaultSize!*2.3 ,
            left: SizeConfig.defaultSize!*2.3 ,
            top: SizeConfig.defaultSize!*6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
         Container(

           height: SizeConfig.defaultSize!*7,
            width: SizeConfig.defaultSize!*38,
            child:CustomButton(
               color: PinkColor,

               child: Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add ,size: 25,color:Teal2Color ,),
                 SizedBox(width: SizeConfig.defaultSize!*2.5,),
                 Text("Add Product",style: TextStyle(color: Teal2Color,fontSize: 25),),
                ],
                ),
               onPressed: (){


                Navigator.pushNamed(context, AddProductScreen.id);

               },
            ),
            ),
            SizedBox(height: SizeConfig.defaultSize!*2,),
            Container(

              height: SizeConfig.defaultSize!*7,
              width: SizeConfig.defaultSize!*38,

              child:CustomButton(
                color: PinkColor,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add ,size: 25,color:Teal2Color ,),
                    SizedBox(width: SizeConfig.defaultSize!*2.5,),
                    Text("Edit Product",style: TextStyle(color: Teal2Color,fontSize: 25),),
                  ],
                ),
                onPressed: (){
                   Navigator.pushNamed(context, EditProduct.id);

                },
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize!*2,),
            Container(

              height: SizeConfig.defaultSize!*7,
              width: SizeConfig.defaultSize!*38,
              child:CustomButton(
                color: PinkColor,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.minimize ,size: 25,color:Teal2Color ,),
                    SizedBox(width: SizeConfig.defaultSize!*2.5,),
                    Text("Delete Product",style: TextStyle(color: Teal2Color,fontSize: 25),),
                  ],
                ),
                onPressed: (){},
              ),
            ),

          ],
        ),
      ),
    );
  }

}