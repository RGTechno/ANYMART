import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "../constants.dart";

class OutletData with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<Map<String, dynamic>> outlets = [];

  Future<List<Map<String, dynamic>>> getAllOutlets() async {
    var allOutlets;
    outlets.clear();
    try {
      allOutlets = await firestore.collection(outletsCollection).get();
      allOutlets.docs.forEach((outlet) {
        outlets.add({
          "merchantName": outlet["merchantName"],
          "category": outlet["category"],
          "outletName": outlet["outletName"],
          "merchantId": outlet["merchantId"],
          "products": outlet["products"],
        });
      });
      // print(outlets);
    } catch (err) {
      print(err);
    }
    return outlets;
  }
}
