import 'package:ecommerce_app/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/helper/constance.dart';
import 'package:ecommerce_app/models/order.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


 final ProductsCollection = FirebaseFirestore.instance.collection("Products") .withConverter(
     fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
     toFirestore: (product, _) => (product as Product).toJson(),);



  addProduct(Product product) {
    ProductsCollection.add(product);
  }


  Stream<QuerySnapshot<Product>> loadProducts() {
    return ProductsCollection .snapshots();
  }

  Stream<QuerySnapshot> loadOrders() {
    return _firestore.collection("Orders").snapshots();
  } 
  
  Stream<QuerySnapshot> loadOrderDertails(documentId) {
    return _firestore.collection("Orders").doc(documentId).collection("OrderDetails").snapshots();
  }

  deleteProduct(String documentId) {

    _firestore.collection("Products").doc(documentId).delete();
  }
  deleteOrder(String documentId) {

    _firestore.collection("Orders").doc(documentId).delete();
  }

  editProduct(data, documentId) {
    _firestore .collection("Products").doc(documentId).update(data);
  }

  storeOrders(data, List<Product> products) {
    var documentRef = _firestore.collection("Orders").doc();
    documentRef.set(data);
    for (var product in products) {
      documentRef.collection("OrderDetails").doc().set({

        "productName": product.pName,
        "productCategory": product.pCategory,
        "productDescription": product.pDescription,
        "productPrice": product.pPrice,
        "productImageUrl": product.pImageUrl,
        "productQuantity":product.Pquantity,
        "productRate":product.Prate,

      });
    }
  }
}




