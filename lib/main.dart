import 'package:anybuy/constants.dart';
import 'package:anybuy/provider/AuthData_Provider.dart';
import 'package:anybuy/provider/Cart_Provider.dart';
import 'package:anybuy/provider/MerchantData_Provider.dart';
import 'package:anybuy/provider/Order_Provider.dart';
import 'package:anybuy/provider/Outlet_Provider.dart';
import 'package:anybuy/screens/AddProduct_Screen.dart';
import 'package:anybuy/screens/Cart_Screen.dart';
import 'package:anybuy/screens/Category_Screen.dart';
import 'package:anybuy/screens/Home_Screen.dart';
import 'package:anybuy/screens/Orders_Screen.dart';
import 'package:anybuy/screens/Outlet_Screen.dart';
import 'package:anybuy/screens/PageviewMainScreen.dart';
import 'package:anybuy/screens/PlaceOrder.dart';
import 'package:anybuy/screens/Profile_Screen.dart';
import 'package:anybuy/screens/afterOrderScreen.dart';
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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthData(),
        ),
        ChangeNotifierProvider(
          create: (context) => MerchantData(),
        ),
        ChangeNotifierProvider(
          create: (context) => OutletData(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartData(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrdersData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AnyBuy',
        theme: ThemeData(
          primarySwatch: color3,
          accentColor: color4,
          fontFamily: "Poppins",
          errorColor: Colors.red,
        ),
        initialRoute: homeScreen,
        routes: {
          profileScreen: (_) => ProfileScreen(),
          afterOrderScreen: (_) => AfterOrderScreen(),
          ordersScreen: (_) => OrdersScreen(),
          cartScreen: (_) => Cart(),
          pageView: (_) => PageViewMainScreen(),
          homeScreen: (_) => HomeScreen(),
          authHome: (_) => AuthHome(),
          merchAuth: (_) => AuthMerchant(),
          addProduct: (_) => AddProduct(),
          singleCategoryScreen: (_) => CategoryScreen(),
          outletScreen: (_) => Outlet(),
          placeOrderScreen: (_) => PlaceOrderScreen()
        },
      ),
    );
  }
}
