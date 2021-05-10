import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
          outletId: outlet.id,
          merchantName: outlet[merchantName],
          category: outlet[category],
          outletName: outlet[outletName],
          merchantId: outlet[merchantId],
          products: outlet[products],
          outletImg: outlet[outletImg],
        });
      });
      print(outlets);
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
          outletId: outlet.id,
          merchantName: outlet[merchantName],
          category: outlet[category],
          outletName: outlet[outletName],
          merchantId: outlet[merchantId],
          products: outlet[products],
          outletImg: outlet[outletImg],
        });
      });
      // print(catOutlets);
    } catch (err) {
      print(err);
    }
    return catOutlets;
  }

  final Map<String, dynamic> outletMerchant = {};

  Future<Map<String, dynamic>> getOutletById(String outId) async {
    var outletsById;
    final Map<String, dynamic> idOutlet = {};
    outletMerchant.clear();
    try {
      outletsById =
          await firestore.collection(outletsCollection).doc(outId).get();
      var outletResponse = outletsById.data();

      var outletMerchantData = await firestore
          .collection(merchantCollection)
          .doc(outletResponse[merchantId])
          .get();

      var merchantResponse = outletMerchantData.data();

      outletMerchant.addAll(merchantResponse);
      // print(outletMerchant);

      idOutlet.addAll(outletResponse);

      // print(response[merchantId]);
    } catch (err) {
      print(err);
    }
    return idOutlet;
  }

  Future<void> updateProduct(String productId) async {
    try {

    } catch (err) {
      print(err);
    }
  }
}
