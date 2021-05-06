import 'package:anybuy/constants.dart';
import 'package:anybuy/provider/AuthData_Provider.dart';
import 'package:anybuy/provider/MerchantData_Provider.dart';
import 'package:anybuy/provider/Order_Provider.dart';
import 'package:anybuy/widgets/Order.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrdersScreen extends StatefulWidget {
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<OrdersData>(context, listen: false);
    final outletID =
        Provider.of<MerchantData>(context, listen: false).currentOutletId;

    final authData = Provider.of<AuthData>(context);

    Future<void> refresh() async {
      setState(() {});
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Orders"),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(
                text: "All Orders",
                icon: Icon(Icons.border_all),
              ),
              Tab(
                text: "Pending",
                icon: Icon(Icons.pending_actions_outlined),
              ),
              Tab(
                text: "Delivered",
                icon: Icon(Icons.done_all_rounded),
              ),
            ],
          ),
        ),
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
                    : TabBarView(children: [
                        ListView.builder(
                          itemBuilder: (_, index) {
                            return Order(
                              orders: orderData.orders[index],
                              outletId: outletID,
                            );
                          },
                          itemCount: orderData.orders.length,
                        ),
                        orderData.pendingOrders.length == 0
                            ? Center(
                                child: Text("No Pending Orders"),
                              )
                            : ListView.builder(
                                itemBuilder: (_, index) {
                                  return Order(
                                    orders: orderData.pendingOrders[index],
                                    outletId: outletID,
                                  );
                                },
                                itemCount: orderData.pendingOrders.length,
                              ),
                        orderData.deliveredOrders.length == 0
                            ? Center(
                                child: Text("No Orders Delivered"),
                              )
                            : ListView.builder(
                                itemBuilder: (_, index) {
                                  return Order(
                                    orders: orderData.deliveredOrders[index],
                                    outletId: outletID,
                                  );
                                },
                                itemCount: orderData.deliveredOrders.length,
                              ),
                      ]);
              }),
        ),
      ),
    );
  }
}
