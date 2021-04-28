import 'package:anybuy/widgets/AppHeader.dart';
import 'package:flutter/material.dart';

class PlaceOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appHeader(context),
      body: Center(
        child: Text("Place Order"),
      ),
    );
  }
}
