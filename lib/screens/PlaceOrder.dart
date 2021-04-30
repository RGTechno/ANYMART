import 'package:anybuy/provider/AuthData_Provider.dart';
import 'package:anybuy/provider/Cart_Provider.dart';
import 'package:anybuy/provider/Order_Provider.dart';
import 'package:anybuy/widgets/AppHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class PlaceOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthData>(context);
    final orderData = Provider.of<OrdersData>(context);
    final cartData = Provider.of<CartData>(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: appHeader(context),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color3,
                      color4,
                    ],
                  ),
                ),
                child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.my_location,
                    color: Colors.white,
                  ),
                  label: Text(
                    "Deliver To Current Location",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 1,
                        offset: Offset(0.2, 0.5),
                        spreadRadius: 0.5),
                  ],
                  // border: Border.all(
                  //   color: Colors.black,
                  //   width: 1.5,
                  // ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Credit/Debit Card"),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Card Number",
                        labelText: "Card Number",
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: "Validity",
                        labelText: "Validity",
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  orderData.placeOrder(
                    cartData.cartItems.values.toList(),
                    cartData.totalAmountWithDelivery,
                    cartData.cartOutletId,
                  );
                  // print(authData.currentUserData["orders"]);
                },
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                  height: 50,
                  width: double.infinity,
                  child: Text(
                    "Place Order",
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
            ],
          ),
        ),
      ),
    );
  }
}
