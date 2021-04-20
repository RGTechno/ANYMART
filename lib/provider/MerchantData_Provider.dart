import 'package:anybuy/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MerchantData with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addProduct(String currentUserId, Map product) async {
    try {
      await firestore.collection(outletsCollection).doc();
      print("data added");
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  Future<void> getProductsWithId(String currentUserId) async {
    var userProducts;
    try {
      userProducts = await firestore
          .collection(outletsCollection)
          .where(
            "merchantId",
            isEqualTo: currentUserId,
          )
          .get();
      userProducts.docs.forEach((doc)=>print(doc.id));
      // print();
    } catch (err) {
      print(err);
    }
    // notifyListeners();
  }
}
