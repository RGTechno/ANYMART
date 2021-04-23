import 'package:flutter/material.dart';

AppBar appHeader(BuildContext ctx) {
  final appBar = AppBar(
    iconTheme: IconThemeData(
      color: Colors.black87,
    ),
    actions: [
      IconButton(
        icon: Icon(Icons.shopping_cart_outlined),
        onPressed: () {},
      ),
    ],
    elevation: 0,
    backgroundColor: Colors.transparent,
  );
  return appBar;
}
