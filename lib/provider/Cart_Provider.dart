import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CartItem {
  final String id;
  final String productId;
  final String productName;
  final double price;
  final int quantity;
  final double count;
  final String proImage;

  CartItem({
    this.id,
    this.productId,
    this.productName,
    this.price,
    this.quantity,
    this.count,
    this.proImage,
  });
}

class CartData with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  void addToCart({
    BuildContext ctx,
    String id,
    String productId,
    String productName,
    double price,
    double countInStock,
    int qty,
    String cat,
    String img,
  }) {
    try {
      if (_cartItems.containsKey(productId)) {
        _cartItems.update(
          productId,
          (existingItem) => CartItem(
            id: existingItem.id,
            price: existingItem.price,
            productName: existingItem.productName,
            quantity: existingItem.quantity + qty,
            count: existingItem.count,
            proImage: existingItem.proImage,
          ),
        );
      } else {
        _cartItems.putIfAbsent(
          productId,
          () => CartItem(
            id: Uuid().v4(),
            productName: productName,
            quantity: qty,
            price: price,
            count: countInStock,
            proImage: img,
          ),
        );
      }

      // print(_cartItems.values.toList().map((e) => print(e.productName)));

      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text("Added To Cart"),
          action: SnackBarAction(
            label: "UNDO",
            onPressed: () {},
          ),
          duration: Duration(
            seconds: 7,
          ),
        ),
      );
    } catch (err) {
      print(err);
    }
    // print(_cartItems);
    notifyListeners();
  }
}
