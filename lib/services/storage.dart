import 'package:ecommerce_app/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_app/helper/constance.dart';

class Store {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


 final Collection = FirebaseFirestore.instance.collection("Products") .withConverter(
     fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
     toFirestore: (product, _) => (product as Product).toJson(),);

  addProduct(Product product) {
    Collection.add(product);
   /* _firestore.collection("Products").add({
      "productName": product.pName,
      "productCategory": product.pCategory,
      "productDescription": product.pDescription,
      "productPrice": product.pPrice,
      "productImageUrl": product.pImageUrl,
    });*/
  }


  Stream<QuerySnapshot<Product>> loadProducts() {
    return /*_firestore.collection("Products") .withConverter(
          fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
          toFirestore: (product, _) => (product as Product).toJson(),
        )*/
       Collection .snapshots();
  }

  deleteProduct(String documentId) {

    _firestore.collection("Products").doc(documentId).delete();
  }

  editProduct(data, documentId) {
    _firestore .collection("Products").doc(documentId).update(data);
  }
}
