import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  int? TotalPrice;
  String? Address;
  String? docId;

  //OrderDetails? details;

  Order({this.TotalPrice, this.Address, this.docId});

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        TotalPrice: json["TotalPrice"],
        Address: json["Address"],
      );

  factory Order.fromFirebase(QueryDocumentSnapshot doc) => Order(
        Address: doc.get("Address"),
        TotalPrice: doc.get("TotalPrice"),
        docId: doc.id,
      );

  Map<String, dynamic> toJson() => {
        "Address": this.Address,
        "TotalPrice": this.TotalPrice,
      };
}
