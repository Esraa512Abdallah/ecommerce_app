import 'package:ecommerce_app/helper/constance.dart';
import 'package:ecommerce_app/helper/sizedConfig.dart';
import 'package:ecommerce_app/services/auth.dart';
import 'package:ecommerce_app/views/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdminHomeScreen extends StatelessWidget {
  Auth _auth = Auth();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              _auth.signOut();
              Navigator.pushNamed(context, "LoginScreen");
            },
            child: Icon(
              Icons.close,
              color: primaryTealColor,
              size: 35,
            )),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Eyeliner Store',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            fontFamily: 'Pacifico',
            color: Colors.pink.shade200,
          ),
        ),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.only(
              right: SizeConfig.defaultSize! * 2.3,
              left: SizeConfig.defaultSize! * 2.3,
              top: SizeConfig.defaultSize! * 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: SizeConfig.defaultSize! * 7,
                width: SizeConfig.defaultSize! * 38,
                child: CustomButton(
                  color: Colors.pink.shade100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: SizeConfig.defaultSize! * 2.5,
                      ),
                      Text(
                        "Add Product",
                        style: TextStyle(color: primaryTealColor, fontSize: 25),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "AddProductScreen");
                  },
                ),
              ),
              SizedBox(
                height: SizeConfig.defaultSize! * 2,
              ),
              Container(
                height: SizeConfig.defaultSize! * 7,
                width: SizeConfig.defaultSize! * 38,
                child: CustomButton(
                  color: Colors.pink.shade100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: SizeConfig.defaultSize! * 2.5,
                      ),
                      Text(
                        "Manage Products",
                        style: TextStyle(color: primaryTealColor, fontSize: 25),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "ManageProducts");
                  },
                ),
              ),
              SizedBox(
                height: SizeConfig.defaultSize! * 2,
              ),
              Container(
                height: SizeConfig.defaultSize! * 7,
                width: SizeConfig.defaultSize! * 38,
                child: CustomButton(
                  color: Colors.pink.shade100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: SizeConfig.defaultSize! * 2.5,
                      ),
                      Text(
                        "View Order",
                        style: TextStyle(color: primaryTealColor, fontSize: 25),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, "OrderScreen");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
