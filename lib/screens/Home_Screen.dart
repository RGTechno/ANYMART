import 'package:anybuy/provider/AuthData_Provider.dart';
import 'package:anybuy/screens/UserHome.dart';
import 'package:anybuy/screens/merchScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthData>(context);
    authData.getCurrentUserData();
    if (authData.currentUserData.isNotEmpty &&
        authData.currentUserData["isMerchant"] == true) {
      return MerchScreen();
    }
    return UserHome();
  }
}
