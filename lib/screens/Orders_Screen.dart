import 'package:anybuy/constants.dart';
import 'package:anybuy/provider/AuthData_Provider.dart';
import 'package:anybuy/provider/MerchantData_Provider.dart';
import 'package:anybuy/provider/Order_Provider.dart';
import 'package:anybuy/widgets/Order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrdersData>(context, listen: false);
    final outletID =
        Provider.of<MerchantData>(context, listen: false).currentOutletId;

    final authData = Provider.of<AuthData>(context);

    Future<void> refresh() async {
      authData.currentUserData["isMerchant"] != true
          ? orderData.getOrders(
              userCollection,
              authData.currentUserData["id"],
            )
          : orderData.getOrders(
              outletsCollection,
              outletID,
            );
    }

    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder(
            future: authData.currentUserData["isMerchant"] != true
                ? orderData.getOrders(
                    userCollection,
                    authData.currentUserData["id"],
                  )
                : orderData.getOrders(
                    outletsCollection,
                    outletID,
                  ),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return orderData.orders.length == 0
                  ? Center(
                      child: Text("No Orders Yet!!"),
                    )
                  : ListView.builder(
                      itemBuilder: (_, index) {
                        return Order(orderData.orders[index]);
                      },
                      itemCount: orderData.orders.length,
                    );
            }),
      ),
    );
  }
}
