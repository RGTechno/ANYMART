import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "../constants.dart";

class OutletData with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getAllOutlets() async {
    var allOutlets;
    List<Map<String, dynamic>> outlets = [];

    try {
      allOutlets = await firestore.collection(outletsCollection).get();
      allOutlets.docs.forEach((outlet) {
        outlets.add({
          merchantName: outlet[merchantName],
          category: outlet[category],
          outletName: outlet[outletName],
          merchantId: outlet[merchantId],
          products: outlet[products],
        });
      });
      // print(outlets);
    } catch (err) {
      print(err);
    }
    return outlets;
  }
}
