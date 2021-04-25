import 'package:anybuy/provider/Cart_Provider.dart';
import 'package:anybuy/widgets/AppHeader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartData>(context);
    print(cartData.cartItems);

    return Scaffold(
      appBar: appHeader(context),
      body: cartData.cartItems.length == 0
          ? Center(
              child: Text("No Item in Cart"),
            )
          : Center(
              child: Column(
                children: cartData.cartItems
                    .map((item) => Text(item[productName]))
                    .toList(),
              ),
            ),
    );
  }
}
