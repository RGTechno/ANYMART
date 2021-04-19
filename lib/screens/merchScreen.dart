import 'package:anybuy/widgets/Drawer.dart';
import 'package:flutter/material.dart';

class MerchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: Center(
        child: Text("Merchant Screen"),
      ),
    );
  }
}
