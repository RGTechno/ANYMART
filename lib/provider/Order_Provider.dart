import 'package:anybuy/constants.dart';
import 'package:anybuy/provider/Cart_Provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrderItem {
  final String id;
  final double totalAmount;
  final List<CartItem> order;
  final DateTime date;

  OrderItem({
    @required this.id,
    @required this.totalAmount,
    @required this.date,
    @required this.order,
  });
}

class OrdersData with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addOrder(
      String collection, String id, Map<String, dynamic> order) async {
    try {
      await firestore
          .collection(collection)
          .doc(id)
          .collection("orders")
          .add(order);
    } catch (err) {
      print(err);
    }
  }

  Future<void> placeOrder(
    List<CartItem> cartProducts,
    double orderAmount,
    String outletID,
  ) async {
    final timeStamp = DateTime.now();
    try {
      await addOrder(userCollection, _auth.currentUser.uid, {
        "totalAmount": orderAmount,
        "orderDateTime": timeStamp.toIso8601String(),
        "order": cartProducts
            .map((ci) => {
                  "id": ci.id,
                  productName: ci.productName,
                  productPrice: ci.price,
                  "quantity": ci.quantity,
                  productImg: ci.proImage,
                })
            .toList(),
      });
      await addOrder(outletsCollection, outletID, {
        "totalAmount": orderAmount,
        "orderDateTime": timeStamp.toIso8601String(),
        "order": cartProducts
            .map((ci) => {
                  "id": ci.id,
                  productName: ci.productName,
                  productPrice: ci.price,
                  "quantity": ci.quantity,
                  productImg: ci.proImage,
                })
            .toList(),
      });
    } catch (err) {
      print(err);
    }
  }
}
