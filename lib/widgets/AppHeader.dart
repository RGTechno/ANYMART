import 'package:anybuy/constants.dart';
import 'package:flutter/material.dart';

AppBar appHeader(BuildContext ctx) {
  final appBar = AppBar(
    iconTheme: IconThemeData(
      color: Colors.black87,
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.shopping_cart_outlined),
        onPressed: () {
          Navigator.of(ctx).pushNamed(cartScreen);
        },
      ),
    ],
    elevation: 0,
    backgroundColor: Colors.transparent,
  );
  return appBar;
}
