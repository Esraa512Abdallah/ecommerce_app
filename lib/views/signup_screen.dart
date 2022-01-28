import 'package:ecommerce_app/Services/auth.dart';
import 'package:ecommerce_app/helper/constance.dart';
import 'package:ecommerce_app/helper/sizedConfig.dart';
import 'package:ecommerce_app/views/login_screen.dart';
import 'package:ecommerce_app/views/widgets/custom_logo.dart';
import 'package:ecommerce_app/views/widgets/custom_textfeild.dart';
import 'package:ecommerce_app/viewsModel/model_view_hud.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget{

 //static const  String id ="SignUpScreen" ;
 final GlobalKey<FormState> _globalKey = GlobalKey();
  String? _email ,_password ;
 final _auth = Auth();

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);


    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.grey[200],
        body: ModalProgressHUD(
          
          inAsyncCall: Provider.of<ModelHud>(context).IsLoading,
          child: Form(
            key: _globalKey,
            child: ListView(
              children: [Container(
                child: Column(
                  children: [
                    Container(
                      height: SizeConfig.screenHeight!/3,
                      width: SizeConfig.screenWidth!,

                      decoration: BoxDecoration(
                        color:MiddleBlueGreenColor,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(90)),


                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            PaleBlueColor,
                            MiddleBlueGreenColor,
                            VerdigrisColor,
                            TealColor,
                          ],
                        ),
                      ),

                      child:Container(

                        child:CustomLogo(),

                      ),

                    ),
                    Padding(
                      padding:  EdgeInsets.only(
                          right:SizeConfig.defaultSize!*2.5,
                          left: SizeConfig.defaultSize!*2.5,
                          top: SizeConfig.defaultSize!*6,
                          bottom: 20),
                      child: Container(
                        child: Column(

                          children: [

                            CustomTextFeild(
                              hintText: "Enter your name",
                              icon: Icons.person,
                              iconcolor: TealColor,
                              keyboardType: TextInputType.text,
                              onClick: (value){

                              },

                            ),

                            SizedBox(height: SizeConfig.defaultSize!*1.2,),

                            CustomTextFeild(
                              hintText: "Enter your email",
                              icon: Icons.mail,
                              iconcolor: TealColor,
                              keyboardType: TextInputType.emailAddress,
                              onClick: (value){
                                _email =value ;
                              },


                            ),

                            SizedBox(height: SizeConfig.defaultSize!*1.2,),

                            CustomTextFeild(
                              hintText: "Enter your password",
                              icon: Icons.lock ,
                              iconcolor: TealColor,
                              keyboardType: TextInputType.visiblePassword,
                              onClick: (value){
                                _password = value ;
                              },

                            ),

                            SizedBox(height: SizeConfig.defaultSize!*3.5,),

                            Padding(
                              padding:EdgeInsets.only(
                                right:SizeConfig.defaultSize!*8,
                                left: SizeConfig.defaultSize!*8,
                              ),
                              child: Builder(
                                builder: (context){
                                  return FlatButton(
                                    onPressed: ()async{

                                      ModelHud modelhud = Provider.of<ModelHud>(context, listen: false);

                                      modelhud.ChangeIsLoading(true);

                                   if( _globalKey.currentState!.validate())
                                      {
                                        _globalKey.currentState!.reset();
                                   try {
                                        final result=  await _auth.signUp(_email!.trim(), _password!.trim());

                                        modelhud.ChangeIsLoading(false);

                                        Navigator.pushNamed(context, "UserHomeScreen");

                                        }  catch (e) {
                                          modelhud.ChangeIsLoading(false);

                                             print(e);
                                           Fluttertoast.showToast(
                                              msg: e.toString(),
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: TealColor,
                                              textColor: Colors.black,
                                              fontSize: 16.0,

                                          );


                                        }

                                      }

                                    },
                                    child:Container(
                                      height: SizeConfig.defaultSize!*5,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomRight:Radius.circular(70),
                                          topLeft: Radius.circular(70),
                                        ),

                                        gradient:  LinearGradient(
                                            begin: Alignment.bottomRight,
                                            end: Alignment.topLeft,
                                            colors: [
                                              PaleBlueColor,
                                              MiddleBlueGreenColor,
                                              VerdigrisColor,
                                              TealColor,
                                            ]

                                        ),
                                      ),
                                      child:Center(
                                        child: Text("SignUp",
                                          style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white,

                                          ),),
                                      ),

                                    ),

                                  );
                                },
                              )
                            ),
                            SizedBox(
                              height: SizeConfig.defaultSize!*2,
                            ),
                            Row(
                              mainAxisAlignment:  MainAxisAlignment.center,
                              children: [
                                Text("Do have an account ?",
                                  style: TextStyle(color: Colors.black ,fontSize: 16),),
                                GestureDetector(

                                  child: Text("Login",
                                    style: TextStyle(color: TealColor ,fontSize: 16),),
                                  onTap: (){
                                    Navigator.pushNamed(context, "LoginScreen");
                                  },
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),],

            ),
          ),
        ),

    );
  }

}