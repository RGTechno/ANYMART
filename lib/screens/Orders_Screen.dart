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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          title: Text("Orders"),
          centerTitle: true,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Theme.of(context).accentColor),
            tabs: [
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("All Orders"),
                    Icon(Icons.border_all),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Pending"),
                    Icon(Icons.pending_actions_outlined),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Delivered"),
                    Icon(Icons.done_all_rounded),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: FutureBuilder(
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
                      RefreshIndicator(
                        onRefresh: refresh,
                        child: ListView.builder(
                          itemBuilder: (_, index) {
                            return Order(
                              orders: orderData.orders[index],
                              outletId: outletID,
                            );
                          },
                          itemCount: orderData.orders.length,
                        ),
                      ),
                      orderData.pendingOrders.length == 0
                          ? Center(
                              child: Text("No Pending Orders"),
                            )
                          : RefreshIndicator(
                              onRefresh: refresh,
                              child: ListView.builder(
                                itemBuilder: (_, index) {
                                  return Order(
                                    orders: orderData.pendingOrders[index],
                                    outletId: outletID,
                                  );
                                },
                                itemCount: orderData.pendingOrders.length,
                              ),
                            ),
                      orderData.deliveredOrders.length == 0
                          ? Center(
                              child: Text("No Orders Delivered"),
                            )
                          : RefreshIndicator(
                              onRefresh: refresh,
                              child: ListView.builder(
                                itemBuilder: (_, index) {
                                  return Order(
                                    orders: orderData.deliveredOrders[index],
                                    outletId: outletID,
                                  );
                                },
                                itemCount: orderData.deliveredOrders.length,
                              ),
                            ),
                    ]);
            }),
      ),
    );
  }
}
