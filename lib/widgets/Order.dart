import 'package:anybuy/provider/AuthData_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/Order_Provider.dart' as or;

class Order extends StatelessWidget {
  final or.OrderItem orders;

  Order(this.orders);

  @override
  Widget build(BuildContext context) {
    final currentUserData = Provider.of<AuthData>(context).currentUserData;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromRGBO(254, 180, 123, 1),
              Color.fromRGBO(255, 126, 95, 1),
            ]),
      ),
      child: Column(
        children: [
          ...orders.order.map(
            (ci) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ci.productName,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontSize: 15),
                ),
                Text(
                  "Qty: ${ci.quantity.toString()}X",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                      fontSize: 15),
                ),
              ],
            ),
          ),
          Divider(thickness: 2),
          currentUserData["isMerchant"] == true
              ? Container()
              : Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 0),
                  // color: Colors.black12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount Paid:",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "\u{20B9}${orders.totalAmount}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
          currentUserData["isMerchant"] != true
              ? Container()
              : Container(
                  margin: const EdgeInsets.only(top: 10, bottom: 0),
                  // color: Colors.black12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Status:",
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        "Pending",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
