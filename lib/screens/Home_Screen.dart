import 'package:anybuy/provider/AuthData_Provider.dart';
import 'package:anybuy/screens/merchScreen.dart';
import 'package:provider/provider.dart';

import '../screens/UserHome.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthData>(context);
    if (authData.currentUserData["isMerchant"] == true &&
        authData.auth.currentUser != null) {
      return MerchScreen();
    }
    return UserHome();
  }
}
