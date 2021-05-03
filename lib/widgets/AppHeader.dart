import 'package:anybuy/constants.dart';
import 'package:anybuy/provider/Cart_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cartBadge.dart';

AppBar appHeader(BuildContext ctx) {
  final cartData = Provider.of<CartData>(ctx, listen: false);
  final appBar = AppBar(
    iconTheme: IconThemeData(
      color: Colors.black87,
    ),
    actions: [
      Consumer<CartData>(
        builder: (_, cart, ch) => Badge(
          child: ch,
          value: cartData.cartItems.length.toString(),
        ),
        child: IconButton(
          icon: Icon(Icons.shopping_cart_outlined),
          onPressed: () {
            Navigator.of(ctx).pushNamed(cartScreen);
          },
        ),
      ),
    ],
    elevation: 0,
    backgroundColor: Colors.transparent,
  );
  return appBar;
}
