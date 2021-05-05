import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../provider/Order_Provider.dart' as or;

class OrderDetail extends StatelessWidget {
  final or.OrderItem orders;
  final Map currentUserData;
  final bool pendingOrders;

  const OrderDetail({
    @required this.orders,
    @required this.currentUserData,
    this.pendingOrders,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
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
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          Divider(thickness: 2),
          Container(
            margin: const EdgeInsets.only(top: 10, bottom: 0),
            // color: Colors.black12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: Text(
                    "Deliver To:",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${orders.placedBy}"),
                      Text(
                        "${orders.location}",
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(thickness: 1),
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
                        "${orders.orderStatus}",
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
