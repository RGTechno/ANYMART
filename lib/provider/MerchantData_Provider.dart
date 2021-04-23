import 'package:anybuy/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MerchantData with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Map<String, dynamic> currentUserProduct = {};
  String currentUserOutletId;

  Future<void> addProduct(BuildContext ctx, Map product) async {
    print(currentUserOutletId);
    try {
      await firestore
          .collection(outletsCollection)
          .doc(currentUserOutletId)
          .update({
        products: FieldValue.arrayUnion([product]),
      });
      // print("data added");
      ScaffoldMessenger.of(ctx).showSnackBar(
        snackBar(
          ctx,
          "Product Added",
          "View",
          homeScreen,
        ),
      );
    } catch (err) {
      // print(err);
      String errMsg = "Unable To Add Product!";
      errorDialog(ctx, errMsg);
    }
    notifyListeners();
  }

  Future<Map<String, dynamic>> getProductsWithId(String currentUserId) async {
    var userProducts;
    currentUserProduct.clear();

    try {
      userProducts = await firestore
          .collection(outletsCollection)
          .where(
            merchantId,
            isEqualTo: currentUserId,
          )
          .get();
      userProducts.docs.forEach((doc) {
        currentUserOutletId = doc.id;
        currentUserProduct.addAll({
          merchantName: doc[merchantName],
          category: doc[category],
          outletName: doc[outletName],
          merchantId: doc[merchantId],
          products: doc[products],
        });
      });
      print(currentUserOutletId);
    } catch (err) {
      print(err);
    }
    return currentUserProduct;
    // notifyListeners();
  }
}
