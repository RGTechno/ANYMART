import 'package:anybuy/provider/Cart_Provider.dart';
import 'package:anybuy/widgets/AppHeader.dart';
import 'package:anybuy/widgets/Cart_Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../widgets/Cart_Item.dart';

class Cart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<CartData>(context);
    final cartItems = cartData.cartItems;
    // print(cartItems.values.toList());
    // print(cartData.cartItems);

    return Scaffold(
      appBar: appHeader(context),
      body: cartData.cartItems.length == 0
          ? Center(
              child: Text("No Item in Cart"),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TotalAmount("Subtotal:", cartData.totalAmount),
                  TotalAmount("Delivery:", 15),
                  Divider(thickness: 0),
                  TotalAmount("Total:", cartData.totalAmount + 15),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                      height: 50,
                      width: double.infinity,
                      child: Text(
                        "Proceed To Pay",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            color3,
                            color4,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  Divider(),
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        var cartItem = cartItems.values.toList()[index];
                        return UserCartItem(
                          productId: cartItems.keys.toList()[index],
                          productName: cartItem.productName,
                          price: cartItem.price,
                          quantity: cartItem.quantity,
                          count: cartItem.count,
                          proImg: cartItem.proImage,
                        );
                      },
                      itemCount: cartItems.length,
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

class TotalAmount extends StatelessWidget {
  final double cost;
  final String costTitle;

  TotalAmount(this.costTitle, this.cost);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            costTitle,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Text(
            "\u{20B9}$cost",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
