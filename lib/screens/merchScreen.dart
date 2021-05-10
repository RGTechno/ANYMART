import 'package:anybuy/constants.dart';
import 'package:anybuy/widgets/Drawer.dart';
import 'package:anybuy/widgets/MerchProduct_Item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/AuthData_Provider.dart';
import '../provider/MerchantData_Provider.dart';

class MerchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthData>(context);
    final user = authData.auth.currentUser;
    final merchantData = Provider.of<MerchantData>(context);

    return Scaffold(
      drawer: DrawerMenu(),
      appBar: AppBar(),
      body: FutureBuilder(
        future: merchantData.getProductsWithId(user.uid),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var sdp = snapshot.data[products];
          return sdp.length == 0
              ? Center(
                  child: Text("No Products Added Yet"),
                )
              : ListView.builder(
                  itemBuilder: (ctx, index) => MerchantProductItem(
                    proId: sdp[index][productId],
                    proName: sdp[index][productName],
                    countInStock: double.parse(
                      sdp[index][countInStock].toString(),
                    ),
                    price: double.parse(
                      sdp[index][productPrice].toString(),
                    ),
                    image: sdp[index][productImg],
                  ),
                  itemCount: sdp.length,
                );
        },
      ),
    );
  }
}
