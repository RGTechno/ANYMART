import 'package:anybuy/constants.dart';
import 'package:anybuy/widgets/Product_Item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/AuthData_Provider.dart';
import '../provider/MerchantData_Provider.dart';
import 'package:anybuy/widgets/Drawer.dart';

class MerchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthData>(context);
    final user = authData.auth.currentUser;
    final merchantData = Provider.of<MerchantData>(context);

    return Scaffold(
      drawer: DrawerMenu(),
      appBar: AppBar(
        title: Text(
          "ANYBUY",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 40,
          ),
        ),
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder(
        future: merchantData.getProductsWithId(user.uid),
        builder: (ctx, snapshot) {
          var sdp = snapshot.data[products];
          if (snapshot.connectionState == ConnectionState.waiting ||
              sdp == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return sdp == null
              ? Center(
                  child: Text("No Products Added Yet"),
                )
              : ListView.builder(
                  itemBuilder: (ctx, index) => ProductItem(
                    proId: sdp[index]["productId"],
                    proName: sdp[index]["productName"],
                    countInStock: double.parse(
                      sdp[index]["countInStock"].toString(),
                    ),
                    price: double.parse(
                      sdp[index]["price"].toString(),
                    ),
                  ),
                  itemCount: sdp.length,
                );
        },
      ),
    );
  }
}
