import 'package:anybuy/constants.dart';
import 'package:anybuy/provider/AuthData_Provider.dart';
import 'package:anybuy/screens/Home_Screen.dart';
import 'package:anybuy/screens/auth/AuthHome_Screen.dart';
import 'package:anybuy/screens/auth/AuthMerch_Screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return ChangeNotifierProvider(
      create: (context) => AuthData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AnyBuy',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: "Poppins",
        ),
        initialRoute: homeScreen,
        routes: {
          authHome: (context) => AuthHome(),
          merchAuth: (context) => AuthMerchant(),
          homeScreen: (context) => HomeScreen(),
        },
      ),
    );
  }
}
