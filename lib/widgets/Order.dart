import 'package:anybuy/provider/AuthData_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './OrderDetail.dart';
import '../provider/Order_Provider.dart' as or;

class Order extends StatelessWidget {
  final or.OrderItem orders;

  Order(this.orders);

  @override
  Widget build(BuildContext context) {
    final currentUserData = Provider.of<AuthData>(context).currentUserData;
    return InkWell(
      onTap: currentUserData["isMerchant"] == true
          ? () {
              orderModalSheet(
                ctx: context,
                orders: orders,
                user: currentUserData,
              );
            }
          : null,
      child: OrderDetail(orders: orders, currentUserData: currentUserData),
    );
  }
}

void orderModalSheet({BuildContext ctx, or.OrderItem orders, Map user}) {
  showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(30),
        topLeft: Radius.circular(30),
      ),
    ),
    context: ctx,
    builder: (_) {
      return Container(
        height: 650,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OrderDetail(orders: orders, currentUserData: user),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    foregroundColor: MaterialStateProperty.all<Color>(
                      Colors.white,
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(ctx).primaryColor,
                    ),
                  ),
                  icon: Icon(
                    Icons.phone,
                  ),
                  onPressed: () {},
                  label: Text("${orders.phone}"),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  onPressed: () {},
                  child: Text("Delivered"),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
