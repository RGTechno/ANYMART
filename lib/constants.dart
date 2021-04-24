import 'package:flutter/material.dart';

const homeScreen = "/homeScreen";
const authHome = "/authHome";
const merchAuth = "/authMerchant";
const addProduct = "/addProduct";
const singleCategoryScreen = "/catScreen";
const outletScreen = "/outletScreen";
const pageView = "/pageViewScreen";

const userCollection = "users";
const merchantCollection = "merchant";
const allUserCollection = "allUsers";
const outletsCollection = "outlets";
const productsCollection = "products";

const merchantName = "merchantName";
const products = "products";
const merchantId = "merchantId";
const outletName = "outletName";
const category = "category";
const outletId = "outletId";
const outletImg = "outletImageURL";

Color color1 = Colors.deepPurpleAccent;
Color color2 = Colors.white70;
Color color3 = Colors.pink;
Color color4 = Colors.redAccent;

void errorDialog(BuildContext ctx, String errorMessage) {
  showDialog(
    context: ctx,
    builder: (ctx) => AlertDialog(
      title: Text("An ERROR Occurred"),
      content: Text(errorMessage),
      actions: [
        TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        ),
      ],
    ),
  );
}

SnackBar snackBar(
  BuildContext ctx,
  String message,
  String actionLabel,
  String navRoute,
) {
  final snackBar = SnackBar(
    content: Text(message),
    action: SnackBarAction(
      label: actionLabel,
      onPressed: () {
        Navigator.of(ctx).pushReplacementNamed(navRoute);
      },
    ),
  );
  return snackBar;
}
