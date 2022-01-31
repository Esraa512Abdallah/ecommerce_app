import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? pName;

  String? pPrice;
  String? pDescription;
  String? pCategory;
  String? pImageUrl;
  String? pId;
  double? Prate;
  int? Pquantity;
  int? Pfavorite;

  Product(
      {this.pCategory,
      this.pDescription,
      this.pName,
      this.pPrice,
      this.pImageUrl,
      this.pId,
      this.Prate,
      this.Pquantity,
      this.Pfavorite});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        pName: json["productName"],
        pPrice: json["productPrice"],
        pDescription: json["productDescription"],
        pCategory: json["productCategory"],
        pImageUrl: json["productImageUrl"],
        Prate: json["productRate"],
        Pquantity: json["productQuantity"],
        Pfavorite: json["productFavorite"],
      );

  factory Product.fromFirestore(QueryDocumentSnapshot doc) => Product(
      pName: doc.get("productName"),
      pPrice: doc.get("productPrice"),
      pDescription: doc.get("productDescription"),
      pCategory: doc.get("productCategory"),
      pImageUrl: doc.get("productImageUrl"),
      pId: doc.id);

  Map<String, dynamic> toJson() => {
        "productName": this.pName,
        "productPrice": this.pPrice,
        "productImageUrl": this.pImageUrl,
        "productDescription": this.pDescription,
        "productCategory": this.pCategory,
      };
}
