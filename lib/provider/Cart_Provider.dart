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

  void snackBar(BuildContext ctx, Function actionPress) {
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text("Added To Cart"),
        action: SnackBarAction(
          label: "UNDO",
          onPressed: actionPress,
        ),
        duration: Duration(
          seconds: 7,
        ),
      ),
    );
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

      // print(_cartItems.values.toList().map((e) => print(e.productId)));
    } catch (err) {
      print(err);
    }
    // print(_cartItems);
    notifyListeners();
  }

  void removeAddedItem(String productId, int quantity) {
    if (!_cartItems.containsKey(productId)) {
      return;
    }
    if (_cartItems[productId].quantity > 1) {
      _cartItems.update(
        productId,
        (existingItem) => CartItem(
          id: existingItem.id,
          proImage: existingItem.proImage,
          productName: existingItem.productName,
          price: existingItem.price,
          count: existingItem.count,
          quantity: existingItem.quantity - quantity,
        ),
      );
    } else {
      _cartItems.remove(productId);
    }
    notifyListeners();
  }

  void deleteCartItem(String productId) {
    // print("Delete runnin");
    _cartItems.remove(productId);
    notifyListeners();
  }
}
