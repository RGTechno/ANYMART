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
  String _cartOutletState;

  String get cartOutletId {
    return _cartOutletState;
  }

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  double get totalAmount {
    double total = 0;
    _cartItems.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
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
          seconds: 1,
        ),
      ),
    );
  }

  Future alertDifferentOutlet(BuildContext ctx) {
    return showDialog(
      context: ctx,
      builder: (ctx) => AlertDialog(
        title: Text("Cannot Add To Cart!!"),
        content: Text("Order must be placed from a single outlet at a time!!"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(false);
            },
            child: Text("OK"),
          ),
        ],
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
    String outletId,
  }) {
    // print(outletId);
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
        snackBar(ctx, () {
          removeAddedItem(productId, qty);
        });
      } else {
        if (_cartItems.length == 0 || outletId == _cartOutletState) {
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
          snackBar(ctx, () {
            removeAddedItem(productId, qty);
          });
          _cartOutletState = outletId;
        } else {
          alertDifferentOutlet(ctx);
        }
        // print(_cartOutletState);
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
    if (_cartItems[productId].quantity > 1 &&
        _cartItems[productId].quantity - quantity != 0) {
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
