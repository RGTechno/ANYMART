import 'package:flutter/material.dart';

class CartData with ChangeNotifier {
  List _cartItems = [];

  List get cartItems {
    return [..._cartItems];
  }

  void addToCart(BuildContext ctx, Map<String, dynamic> product, String cat) {
    try {
      _cartItems.add(product);
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
