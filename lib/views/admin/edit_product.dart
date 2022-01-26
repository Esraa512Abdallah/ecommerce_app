import 'dart:io';

import 'package:ecommerce_app/helper/constance.dart';
import 'package:ecommerce_app/helper/sizedConfig.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/services/storage.dart';
import 'package:ecommerce_app/views/widgets/custom_textfeild.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProduct extends StatefulWidget {
  static const String id ="EditProduct";

  const EditProduct({Key? key}) : super(key: key);

  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {


  GlobalKey<FormState> _globalKey = GlobalKey();
  String? _name , _price ,_catogry , _description,_imageUrl   ;

  final _store = Store();


  XFile? selectedImage ;
  XFile? selectedPhoto ;
  int x = 0 ;

  @override
  Widget build(BuildContext context) {







    debugPrint(ModalRoute.of(context).toString());


    Product product =  ModalRoute.of(context)!.settings.arguments  as Product;
    print("product:${product}");
  /* if(product != null) {
     print("product:${product}");
     print("productId:${product.pId!}");
   }*/


   // String y = ModalRoute.of(context)!.settings.arguments;

    SizeConfig().init(context);

    return Scaffold(
      appBar:  AppBar(

        backgroundColor: Teal2Color,
        centerTitle: true,
        title: Text("Add Product" , style:  TextStyle(
            fontWeight: FontWeight.w500 , fontSize:25 ,color: Colors.white,fontFamily: 'Pacifico'
        ),),


      ),
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: EdgeInsets.only(
              right: SizeConfig.defaultSize!*2.3 ,
              left: SizeConfig.defaultSize!*2.3 ,
              top: SizeConfig.defaultSize!*6),

          children: [
            Container(

              child:  (x==1)?(selectedImage == null ? null :
              Image.file(File(selectedImage!.path),
                width: SizeConfig.defaultSize!*30,
                height: SizeConfig.defaultSize!*30,))
                  :(x==2)?(selectedPhoto == null ? null :
              Image.file(File(selectedPhoto!.path),
                width: SizeConfig.defaultSize!*30,
                height: SizeConfig.defaultSize!*30,)):null,

            ),

            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  IconButton(
                    onPressed: (){
                      x=1;
                      PickerGallery();
                    },
                    icon:Icon(Icons.image , color: Colors.black,size: 35,),
                  ),

                  IconButton(
                    onPressed: (){
                      x=2;
                      PickerCamera();
                    },
                    icon:Icon(Icons.camera_alt , color: Colors.black,size: 35,),
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConfig.defaultSize!*2,),
            CustomTextFeild(
              hintText: "Enter Product Name ",
              icon: null,
              iconcolor: null,
              keyboardType: TextInputType.text,
              onClick: (value){
                _name = value ;
              },
            ),
            SizedBox(height: SizeConfig.defaultSize!*2,),
            CustomTextFeild(
              hintText: "Enter Product Price ",
              icon: null,
              iconcolor: null,
              keyboardType: TextInputType.text,
              onClick: (value){
                _price = value ;
              },
            ),
            SizedBox(height: SizeConfig.defaultSize!*2,),
            CustomTextFeild(
              hintText: "Enter Product Description ",
              icon: null,
              iconcolor: null,
              keyboardType: TextInputType.text,
              onClick: (value){
                _description = value ;
              },
            ),
            SizedBox(height: SizeConfig.defaultSize!*2,),
            CustomTextFeild(
              hintText: "Enter Product Catogry ",
              icon: null,
              iconcolor: null,
              keyboardType: TextInputType.text,
              onClick: (value){
                _catogry = value ;
              },
            ),
            SizedBox(height: SizeConfig.defaultSize!*2,),

            Builder(
                builder: (context) {
                  return FlatButton(
                      onPressed: (){
                        if(_globalKey.currentState!.validate()){

                          _globalKey.currentState!.save();
                          if(x==1){
                            UploadImage(context);
                          }else if(x==2){
                            Uploadphoto(context);
                          }


                          _store.editProduct({
                            kProductName: _name,
                            kProductPrice: _price,
                            kProductDescription: _description,
                            kProductCategory: _catogry,
                            kProductImage: _imageUrl,
                          } ,product.pId

                          );



                          _globalKey.currentState!.reset();

                        }
                      },
                      child:Container(
                        color: PinkColor,
                        height: SizeConfig.defaultSize!*5,
                        width: SizeConfig.defaultSize!*20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add),
                            Text(  "Edit" ),
                          ],
                        ),
                      ));
                }
            )
          ],
        ),
      ),
    );
  }


  Future PickerGallery () async {
    XFile? image = (await  ImagePicker().pickImage(source: ImageSource.gallery)) ;

    setState(() {
      selectedImage = image ! ;
    });
  }
  Future PickerCamera () async {
    XFile? photo = (await  ImagePicker().pickImage(source: ImageSource.camera)) ;

    setState(() {
      selectedPhoto = photo ! ;
    });
  }

  void UploadImage(context)async{

    try {
      x=1;
      FirebaseStorage storage = FirebaseStorage.instanceFor(
          bucket: "gs://ecommerceapp-ed916.appspot.com");
      // StorageReference ref = storage.ref().child(selectedImage!.path);
      Reference ref = storage.ref().child(selectedImage!.path);
      UploadTask uploadTask = ref.putFile(File(selectedImage!.path));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(
              () async{
            _imageUrl= await ref.getDownloadURL();
          });
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('success'),
      ));
    }catch  (ex) {
      print("exception is:$ex");
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("$ex"),

      ));
    }

  }
  void Uploadphoto(context)async{
    try {
      x=2;
      FirebaseStorage storage = FirebaseStorage.instanceFor(
          bucket: "gs://ecommerceapp-ed916.appspot.com");

      Reference ref = storage.ref().child(selectedPhoto!.path);

      UploadTask uploadTask = ref.putFile(File(selectedPhoto!.path));


      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(
              () {
            setState(()async {
              _imageUrl = await ref.getDownloadURL();

              print("image url......:$_imageUrl");
            });

          });


      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('success'),
      ));

    } catch (ex) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("$ex"),
      ));
    }

  }


}

/////////////////////////////