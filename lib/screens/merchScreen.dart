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
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Center(
            child: Text("Data Fetched"),
          );
        },
      ),
    );
  }
}
