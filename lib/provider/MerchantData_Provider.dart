import 'dart:io';

import 'package:anybuy/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class MerchantData with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Map<String, dynamic> _currentUserProduct = {};

  Map<String, dynamic> get currentUserProduct {
    return {..._currentUserProduct};
  }

  String _currentUserOutletId;

  String get currentOutletId {
    return _currentUserOutletId;
  }

  Future<void> addProduct({
    BuildContext ctx,
    String proName,
    double count,
    double price,
    File image,
  }) async {
    // print(currentUserOutletId);
    try {
      final ref = storage
          .ref()
          .child("product_images")
          .child(_currentUserOutletId)
          .child(
            Uuid().v4(),
          );

      await ref.putFile(image);

      final url = await ref.getDownloadURL();

      await firestore
          .collection(outletsCollection)
          .doc(_currentUserOutletId)
          .update({
        products: FieldValue.arrayUnion([
          {
            productId: Uuid().v4(),
            productName: proName,
            countInStock: count,
            productPrice: price,
            productImg: url,
          }
        ]),
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

  Future<void> deleteProduct({
    String productId,
    String proName,
    double count,
    double price,
    String productImageUrl,
  }) async {
    var productsList = [..._currentUserProduct[products]];
    productsList.removeWhere((element) => element["productId"] == productId);
    print(productsList);
    try {
      await firestore
          .collection(outletsCollection)
          .doc(_currentUserOutletId)
          .update({
        products: productsList,
      });
      print(_currentUserProduct);
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  Future<Map<String, dynamic>> getProductsWithId(String currentUserId) async {
    var userProducts;
    _currentUserProduct.clear();

    try {
      userProducts = await firestore
          .collection(outletsCollection)
          .where(
            merchantId,
            isEqualTo: currentUserId,
          )
          .get();
      userProducts.docs.forEach((doc) {
        _currentUserOutletId = doc.id;
        _currentUserProduct.addAll({
          merchantName: doc[merchantName],
          category: doc[category],
          outletName: doc[outletName],
          merchantId: doc[merchantId],
          products: doc[products],
        });
      });
      // print(currentUserOutletId);
    } catch (err) {
      print(err);
    }
    return _currentUserProduct;
    // notifyListeners();
  }
}
