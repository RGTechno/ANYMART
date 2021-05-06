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
  final String phone;
  final String placedBy;
  final String orderStatus;
  final String userId;

  OrderItem({
    @required this.id,
    @required this.totalAmount,
    @required this.date,
    @required this.order,
    @required this.location,
    @required this.phone,
    @required this.placedBy,
    @required this.orderStatus,
    @required this.userId,
  });
}

class OrdersData with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<OrderItem> _orders = [];

  List<OrderItem> _pendingOrders = [];
  List<OrderItem> _deliveredOrders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  List<OrderItem> get pendingOrders {
    return [..._pendingOrders];
  }

  List<OrderItem> get deliveredOrders {
    return [..._deliveredOrders];
  }

  Future<void> addOrder(
    String collection,
    String id,
    Map<String, dynamic> order,
    String docId,
  ) async {
    try {
      await firestore
          .collection(collection)
          .doc(id)
          .collection("orders")
          .doc(docId)
          .set(order);
    } catch (err) {
      print(err);
    }
  }

  Future<void> placeOrder({
    @required BuildContext ctx,
    @required List<CartItem> cartProducts,
    @required double orderAmount,
    @required String outletID,
    @required String location,
    @required String phone,
    @required String placedBy,
    @required String documentId,
    Function orderHandler,
  }) async {
    final timeStamp = DateTime.now();
    try {
      print(phone);
      if (location == null || phone == null) {
        return showDialog(
          context: ctx,
          builder: (ctx) => AlertDialog(
            title: Text("Cannot Place Order!!"),
            content:
                Text("Delivery Location and Phone Number must be provided."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pushNamed(profileScreen);
                },
                child: Text("Go to profile"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(false);
                },
                child: Text("OK"),
              ),
            ],
          ),
        );
      } else {
        await addOrder(
          userCollection,
          _auth.currentUser.uid,
          {
            "userId": "${_auth.currentUser.uid}",
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
            "phoneNumber": phone,
            "placedBy": placedBy,
            "status": "Pending",
          },
          documentId,
        );
        await addOrder(
          outletsCollection,
          outletID,
          {
            "userId": "${_auth.currentUser.uid}",
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
            "phoneNumber": phone,
            "placedBy": placedBy,
            "status": "Pending",
          },
          documentId,
        );
        orderHandler();
      }
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  Future<void> getOrders(String collection, String id) async {
    var orderResponse;
    List<OrderItem> loadedOrders = [];
    List<OrderItem> loadedPendingOrders = [];
    List<OrderItem> loadedDeliveredOrders = [];

    try {
      orderResponse = await firestore
          .collection(collection)
          .doc(id)
          .collection("orders")
          .orderBy("orderDateTime", descending: false)
          .get();

      orderResponse.docs.forEach((doc) {
        if (doc["status"] == "Pending") {
          loadedPendingOrders.insert(
            0,
            OrderItem(
              userId: doc["userId"],
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
              phone: doc["phoneNumber"],
              placedBy: doc["placedBy"],
              orderStatus: doc["status"],
            ),
          );
        } else if (doc["status"] == "Delivered") {
          loadedDeliveredOrders.insert(
            0,
            OrderItem(
              userId: doc["userId"],
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
              phone: doc["phoneNumber"],
              placedBy: doc["placedBy"],
              orderStatus: doc["status"],
            ),
          );
        }
        loadedOrders.insert(
          0,
          OrderItem(
            userId: doc["userId"],
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
            phone: doc["phoneNumber"],
            placedBy: doc["placedBy"],
            orderStatus: doc["status"],
          ),
        );
      });

      // print(_orders.map((oi) => oi.order.map((ci) => print("${ci.productName}"))));
      // print(_orders.map((oi) => print(oi)));

      _orders = loadedOrders;
      _pendingOrders = loadedPendingOrders;
      _deliveredOrders = loadedDeliveredOrders;
      // print(_deliveredOrders);

      // print(orderResponse);
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  Future<void> updateOrderStatus(
      {String outId, String orderId, String userId}) async {
    try {
      await firestore
          .collection(outletsCollection)
          .doc(outId)
          .collection("orders")
          .doc(orderId)
          .update({
        "status": "Delivered",
      });
      await firestore
          .collection(userCollection)
          .doc(userId)
          .collection("orders")
          .doc(orderId)
          .update({
        "status": "Delivered",
      });
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }
}
