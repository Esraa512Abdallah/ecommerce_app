import 'package:flutter/cupertino.dart';

class CustomLogo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(

      alignment: Alignment.center,
      children: [
        Image.asset("assets/icons/buy.png",),
        Positioned(

          bottom: 63,
          child:Text('Eyeliner Store',
            style: TextStyle(
              fontSize: 30,
              fontFamily:'Pacifico',
            ),
          ),)
      ],
    );
  }

}