import 'package:anybuy/provider/Cart_Provider.dart';
import 'package:anybuy/widgets/AppHeader.dart';
import 'package:anybuy/widgets/Cart_Item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/Cart_Item.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartData>(context);
    final cartItems = cartData.cartItems;
    // print(cartItems.values.toList());
    print(cartData.cartItems);

    return Scaffold(
      appBar: appHeader(context),
      body: cartData.cartItems.length == 0
          ? Center(
              child: Text("No Item in Cart"),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                var cartItem = cartItems.values.toList()[index];
                return UserCartItem(
                  productId: cartItem.productId,
                  productName: cartItem.productName,
                  price: cartItem.price,
                  quantity: cartItem.quantity,
                  count: cartItem.count,
                  proImg: cartItem.proImage,
                );
              },
              itemCount: cartItems.length,
            ),
    );
  }
}
