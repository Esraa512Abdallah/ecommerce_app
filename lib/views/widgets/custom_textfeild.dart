import 'package:ecommerce_app/helper/constance.dart';
import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget{

  late final String hintText ;
   final IconData? icon ;
   final Color? iconcolor ;
  late final TextInputType keyboardType ;
  late final Function(String?)? onClick;


  String? _errorMessage(String str) {
    switch (hintText) {
      case 'Enter your name':
        return 'Name is empty !';
      case 'Enter your email':
        return 'Email is empty !';
      case 'Enter your password':
        return 'Password is empty !';
    }
  }


  CustomTextFeild({required this.hintText, required this.icon,
    required this.keyboardType,required this.onClick,required this.iconcolor});



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  TextFormField(

      validator:(value){


        if(value!.isEmpty){
          return _errorMessage(hintText);
        }
      } ,

      onSaved: onClick,
      cursorColor: TealColor,
      textDirection: TextDirection.ltr,
      keyboardType: keyboardType,

      obscureText: (hintText=="Enter your password")?true:false,
      enableSuggestions: (hintText=="Enter your password")?false:true,
      style: TextStyle(fontSize: 16 ,fontWeight: FontWeight.w500,letterSpacing: 0.5 ,wordSpacing: 1.5),

      decoration:InputDecoration(



        filled: true,
        fillColor: FeildfillColor,
        hintText:hintText,
        hintStyle: TextStyle(color: Colors.grey ,letterSpacing: 0.5 ,wordSpacing: 1.5),

        prefixIcon: Icon((icon != true )?icon:icon  , color: (iconcolor != null)? iconcolor :Colors.transparent,) ,





        enabledBorder:OutlineInputBorder(

          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white,
            width: 1.8,
          ),
        ),
        focusedBorder:OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: Colors.white ,width: 1.8)


        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: Colors.white ,width: 1.8)


        ),
      ) ,
    );
  }

}