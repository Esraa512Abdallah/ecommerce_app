
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(

      alignment: Alignment.center,
      children: [
        Image.asset("assets/icons/buy.png",),
        Positioned(
          bottom: 60,
          child:Text("Eyeliner Store",
            style: TextStyle(
              color:Colors.white,
              fontSize: 30,
              fontFamily:'Pacifico',
            ),
          ),)
      ],
    );
  }

}

