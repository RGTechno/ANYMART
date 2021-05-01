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
  final String location;

  OrderItem({
    @required this.id,
    @required this.totalAmount,
    @required this.date,
    @required this.order,
    @required this.location,
  });
}

class OrdersData with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

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

  Future<void> placeOrder({
    List<CartItem> cartProducts,
    double orderAmount,
    String outletID,
    String location,
  }) async {
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
        "deliveryLocation": location,
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
        "deliveryLocation": location,
      });
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  Future<void> getOrders(String collection, String id) async {
    var orderResponse;
    List<OrderItem> loadedOrders = [];
    try {
      orderResponse = await firestore
          .collection(collection)
          .doc(id)
          .collection("orders")
          .get();

      orderResponse.docs.forEach((doc) {
        loadedOrders.insert(
          0,
          OrderItem(
            id: doc.id,
            totalAmount: doc["totalAmount"],
            date: DateTime.parse(doc["orderDateTime"]),
            order: (doc["order"] as List<dynamic>)
                .map(
                  (ci) => CartItem(
                    id: ci["id"],
                    quantity: ci["quantity"],
                    price: ci["price"],
                    productName: ci[productName],
                    proImage: ci[productImg],
                  ),
                )
                .toList(),
            location: doc["deliveryLocation"],
          ),
        );
      });

      // print(_orders.map((oi) => oi.order.map((ci) => print("${ci.productName}"))));
      // print(_orders.map((oi) => print(oi)));

      _orders = loadedOrders;
      print(_orders);

      // print(orderResponse);
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }
}
