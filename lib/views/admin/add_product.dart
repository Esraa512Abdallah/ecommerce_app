import 'dart:io';

import 'package:ecommerce_app/helper/constance.dart';
import 'package:ecommerce_app/helper/sizedConfig.dart';
import 'package:ecommerce_app/models/product.dart';
import 'package:ecommerce_app/services/storage.dart';
import 'package:ecommerce_app/views/widgets/custom_textfeild.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddProductScreenState();
  }
}

class AddProductScreenState extends State<AddProductScreen> {
  String? _name, _price, _catogry, _description, _imageUrl;

  final _store = Store();

  XFile? selectedImage;

  XFile? selectedPhoto;

  int x = 0;

  GlobalKey<FormState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "AdminHomeScreen");
            },
            child: Icon(
              Icons.arrow_back,
              color: primaryTealColor,
              size: 35,
            )),
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Add Product",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25,
              color: primaryTealColor,
              fontFamily: 'Pacifico'),
        ),
      ),
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: EdgeInsets.only(
              right: SizeConfig.defaultSize! * 2.3,
              left: SizeConfig.defaultSize! * 2.3,
              top: SizeConfig.defaultSize! * 6),
          children: [
            Container(
              child: (x == 1)
                  ? Image.file(
                          File(selectedImage!.path),
                          width: SizeConfig.defaultSize! * 30,
                          height: SizeConfig.defaultSize! * 30,
                        )
                  : (x == 2)
                      ?
                          Image.file(
                              File(selectedPhoto!.path),
                              width: SizeConfig.defaultSize! * 30,
                              height: SizeConfig.defaultSize! * 30,
                            )
                      : null,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      x = 1;
                      PickerGallery();
                    },
                    icon: Icon(
                      Icons.image,
                      color: Colors.black,
                      size: 35,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      x = 2;
                      PickerCamera();
                    },
                    icon: Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                      size: 35,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: SizeConfig.defaultSize! * 2,
            ),
            CustomTextFeild(
              fillColor: Colors.pink.shade100,
              hintText: "Enter Product Name ",
              icon: null,
              iconcolor: null,
              keyboardType: TextInputType.text,
              onClick: (value) {
                _name = value;
              },
            ),
            SizedBox(
              height: SizeConfig.defaultSize! * 2,
            ),
            CustomTextFeild(
              fillColor: Colors.pink.shade100,
              hintText: "Enter Product Price ",
              icon: null,
              iconcolor: null,
              keyboardType: TextInputType.text,
              onClick: (value) {
                _price = value;
              },
            ),
            SizedBox(
              height: SizeConfig.defaultSize! * 2,
            ),
            CustomTextFeild(
              fillColor: Colors.pink.shade100,
              hintText: "Enter Product Description ",
              icon: null,
              iconcolor: null,
              keyboardType: TextInputType.text,
              onClick: (value) {
                _description = value;
              },
            ),
            SizedBox(
              height: SizeConfig.defaultSize! * 2,
            ),
            CustomTextFeild(
              fillColor: Colors.pink.shade100,
              hintText: "Enter Product Catogry ",
              icon: null,
              iconcolor: null,
              keyboardType: TextInputType.text,
              onClick: (value) {
                _catogry = value;
              },
            ),
            SizedBox(
              height: SizeConfig.defaultSize! * 2,
            ),
            Builder(builder: (context) {
              return Container(
                padding: EdgeInsets.only(
                    top: SizeConfig.defaultSize! * 1, left: 60, right: 60),
                child: RaisedButton(
                  color: Colors.teal.shade500,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  )),
                  onPressed: () {
                    if (_globalKey.currentState!.validate()) {
                      _globalKey.currentState!.save();
                      if (x == 1) {
                        UploadImage(context);
                      } else if (x == 2) {
                        Uploadphoto(context);
                      }

                      _store.addProduct(Product(
                        pName: _name,
                        pPrice: _price,
                        pDescription: _description,
                        pCategory: _catogry,
                        pImageUrl: _imageUrl,
                      ));

                    //  _globalKey.currentState!.reset();

                    }
                    print(_price);
                    print(_imageUrl);
                    print(_catogry);
                    print(_name);
                    print(_description);
                  },
                  child: Container(
                    height: SizeConfig.defaultSize! * 4.5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        Text(
                          "Add",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }

  Future PickerGallery() async {
    XFile? image = (await ImagePicker().pickImage(source: ImageSource.gallery));

    setState(() {
      selectedImage = image;
    });
  }

  Future PickerCamera() async {
    XFile? photo = (await ImagePicker().pickImage(source: ImageSource.camera));

    setState(() {
      selectedPhoto = photo;
    });
  }

  void UploadImage(context) async {
    try {
      x = 1;
      FirebaseStorage storage = FirebaseStorage.instanceFor(
          bucket: "gs://ecommerceapp-ed916.appspot.com");
      Reference ref = storage.ref().child(selectedImage!.path);
      UploadTask uploadTask = ref.putFile(File(selectedImage!.path));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() async {
        _imageUrl = await ref.getDownloadURL();
      });
      Fluttertoast.showToast(
        msg: "Successful addition",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 12,
        backgroundColor: Colors.grey[200],
        textColor: primaryPinkColor,
        webPosition: "right",
        fontSize: 20.0,
      );
    } catch (ex) {
      Fluttertoast.showToast(
        msg: "Image exception...: $ex",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 12,
        backgroundColor: Colors.grey[200],
        textColor: primaryPinkColor,
        webPosition: "right",
        fontSize: 20.0,
      );

      print("image exception : $ex");
    }
  }

  void Uploadphoto(context) async {
    try {
      x = 2;
      FirebaseStorage storage = FirebaseStorage.instanceFor(
          bucket: "gs://ecommerceapp-ed916.appspot.com");

      Reference ref = storage.ref().child(selectedPhoto!.path);

      UploadTask uploadTask = ref.putFile(File(selectedPhoto!.path));

      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {
        setState(() async {
          _imageUrl = await ref.getDownloadURL();

          print("image url......:$_imageUrl");
        });
      });

      Fluttertoast.showToast(
        msg: 'Successful addition',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 12,
        backgroundColor: Colors.grey[200],
        textColor: primaryPinkColor,
        webPosition: "right",
        fontSize: 20.0,
      );
    } catch (ex) {
      Fluttertoast.showToast(
        msg: "Image exception...: $ex",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 12,
        backgroundColor: Colors.grey[200],
        textColor: primaryPinkColor,
        webPosition: "right",
        fontSize: 20.0,
      );
      print("image exception : $ex");
    }
  }
}
