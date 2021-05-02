import 'package:anybuy/constants.dart';
import 'package:flutter/material.dart';

class AfterOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Thank You!! Your Order Has Been Placed."),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(homeScreen);
              },
              child: Text("Continue Shopping"),
            ),
          ],
        ),
      ),
    );
  }
}
