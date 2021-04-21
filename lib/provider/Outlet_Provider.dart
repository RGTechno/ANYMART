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

  Future<List<Map<String, dynamic>>> getOutletsByCategory(String cat) async {
    // print(category);
    var outletsByCat;
    final List<Map<String, dynamic>> catOutlets = [];
    try {
      outletsByCat = await firestore
          .collection(outletsCollection)
          .where(
            category,
            isEqualTo: cat,
          )
          .get();
      outletsByCat.docs.forEach((outlet) {
        catOutlets.add({
          merchantName: outlet[merchantName],
          category: outlet[category],
          outletName: outlet[outletName],
          merchantId: outlet[merchantId],
          products: outlet[products],
        });
      });
      // print(catOutlets);
    } catch (err) {
      print(err);
    }
    return catOutlets;
  }
}