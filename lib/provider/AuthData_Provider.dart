import 'dart:io';

import 'package:anybuy/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class AuthData with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  FirebaseAuth get auth {
    return _auth;
  }

  bool _isAuth = false;

  Map _currentUserData = {};

  Map get currentUserData {
    return {..._currentUserData};
  }

  bool get isAuth {
    return _isAuth;
  }

  Future<void> deleteAuth() async {
    try {
      await _auth.currentUser.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print(
            'The user must reauthenticate before this operation can be executed.');
      }
    }
  }

  Future<void> deleteMerchant() async {
    try {
      await firestore
          .collection(allUserCollection)
          .doc(_auth.currentUser.uid)
          .delete();
      await firestore
          .collection(merchantCollection)
          .doc(_auth.currentUser.uid)
          .delete();
    } catch (err) {
      print(err);
    }
  }

  Future<void> deleteUser() async {
    WriteBatch batch = firestore.batch();
    try {
      await firestore
          .collection(allUserCollection)
          .doc(_auth.currentUser.uid)
          .delete();

      var userOrders = await firestore
          .collection(userCollection)
          .doc(_auth.currentUser.uid)
          .collection("orders")
          .get();

      userOrders.docs.forEach((doc) {
        batch.delete(doc.reference);
      });

      await firestore
          .collection(userCollection)
          .doc(_auth.currentUser.uid)
          .delete();

      return batch.commit();
    } catch (err) {
      print(err);
    }
  }

  Future<void> deleteOutlet() async {
    WriteBatch batch = firestore.batch();

    try {
      var outlet = await firestore
          .collection(outletsCollection)
          .where("merchantId", isEqualTo: _auth.currentUser.uid)
          .get();

      outlet.docs.forEach((doc) async {
        await doc.reference.delete();
        var outletOrders = await doc.reference.collection("orders").get();
        outletOrders.docs.forEach((order) {
          batch.delete(order.reference);
        });
      });
    } catch (err) {
      print(err);
    }
  }

  Future<void> deleteUserAccount() async {
    try {
      await deleteUser();
      await deleteAuth();
      _currentUserData.clear();
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  Future<void> deleteMerchantAccount() async {
    try {
      await deleteOutlet();
      await deleteMerchant();
      await deleteAuth();
      _currentUserData.clear();
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  Future<void> createOutlet(
    String id,
    String name,
    String inputOutletName,
    String cat,
    String imageUrl,
  ) async {
    try {
      await firestore.collection("/$outletsCollection").add({
        merchantId: id,
        merchantName: name,
        outletName: inputOutletName,
        category: cat,
        products: [],
        outletImg: imageUrl,
      });
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  void createUser({
    @required String email,
    @required String pass,
    @required String firstname,
    @required String lastname,
    BuildContext ctx,
  }) async {
    // print("create user running");
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      await firestore
          .collection(allUserCollection)
          .doc("${userCredential.user.uid}")
          .set({
        "id": "${userCredential.user.uid}",
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "initials": "${firstname[0].toUpperCase()}${lastname[0].toUpperCase()}",
      });

      await firestore
          .collection(userCollection)
          .doc("${userCredential.user.uid}")
          .set({
        "id": "${userCredential.user.uid}",
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "initials": "${firstname[0].toUpperCase()}${lastname[0].toUpperCase()}",
      });

      ScaffoldMessenger.of(ctx).showSnackBar(
        snackBar(
          ctx,
          "User Created Successfully",
          "Login",
          authHome,
        ),
      );

      // print(
      //   "User Created ${userCredential.user.email}, ${userCredential.user.uid}",
      // );
    } on FirebaseAuthException catch (e) {
      String errMessage = "Unable To Create User!";
      if (e.code == 'email-already-in-use') {
        errMessage = 'The account already exists for that email.';
        errorDialog(ctx, errMessage);
      } else
        errorDialog(ctx, errMessage);
    } catch (e) {
      // print(e);
      errorDialog(ctx, "${e.message}");
    }
  }

  Future<void> updateAccountDetails({
    @required String firstname,
    @required String lastname,
    String phoneNo,
    String location,
  }) async {
    try {
      await firestore
          .collection(allUserCollection)
          .doc(_auth.currentUser.uid)
          .update({
        "firstname": firstname,
        "lastname": lastname,
        "phoneNumber": phoneNo,
        "location": location,
      });
    } catch (err) {
      print(err);
    }
    notifyListeners();
  }

  void createMerchant({
    @required String email,
    @required String pass,
    @required String firstname,
    @required String lastname,
    @required String outletName,
    @required String category,
    File outletImage,
    BuildContext ctx,
  }) async {
    print("create user running");
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      final ref =
          storage.ref().child("outlet_images").child(userCredential.user.uid);

      await ref.putFile(outletImage);

      final url = await ref.getDownloadURL();

      await firestore
          .collection(allUserCollection)
          .doc("${userCredential.user.uid}")
          .set({
        "id": "${userCredential.user.uid}",
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "isMerchant": true,
        "outlet": outletName,
        "category": category,
        "initials": "${firstname[0].toUpperCase()}${lastname[0].toUpperCase()}",
      });

      await firestore
          .collection(merchantCollection)
          .doc("${userCredential.user.uid}")
          .set({
        "id": "${userCredential.user.uid}",
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "isMerchant": true,
        "outlet": outletName,
        "category": category,
        "initials": "${firstname[0].toUpperCase()}${lastname[0].toUpperCase()}",
      });

      await createOutlet(
        userCredential.user.uid,
        "$firstname $lastname",
        outletName,
        category,
        url,
      );

      ScaffoldMessenger.of(ctx).showSnackBar(
        snackBar(
          ctx,
          "User Created Successfully",
          "Login",
          merchAuth,
        ),
      );

      // print(
      //   "User Created ${userCredential.user.email}, ${userCredential.user.uid}",
      // );
    } on FirebaseAuthException catch (e) {
      String errMessage = "Unable To Create Merchant!";
      if (e.code == 'email-already-in-use') {
        errMessage = 'The account already exists for that email.';
        errorDialog(ctx, errMessage);
      } else
        errorDialog(ctx, errMessage);
    } catch (e) {
      // print(e);
      errorDialog(ctx, "${e.message}");
    }
  }

  Future<void> login(String email, String pass, BuildContext ctx) async {
    print("login running");
    _currentUserData.clear();

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      print(userCredential.user.email);
      await getCurrentUserData();
    } on FirebaseAuthException catch (e) {
      String errMessage = "Unable To Authenticate!";
      if (e.code == 'user-not-found') {
        errMessage = 'No user found for that email.';
        errorDialog(ctx, errMessage);
      } else if (e.code == 'wrong-password') {
        errMessage = 'Wrong password provided for that user.';
        errorDialog(ctx, errMessage);
      } else
        errorDialog(ctx, errMessage);
    }
  }

  Future<void> signOut(BuildContext ctx) async {
    await auth.signOut();
    _currentUserData.clear();

    Navigator.of(ctx).pop();
    notifyListeners();
  }

  Future<void> getCurrentUserData(
      {String collection = "$allUserCollection"}) async {
    var data;
    try {
      var currentData = await firestore
          .collection(collection)
          .doc(_auth.currentUser.uid)
          .get();
      data = currentData.data();
      // print(data);
      _currentUserData.addAll(data);
      print(currentUserData);
    } catch (e) {
      print(e);
    }
  }
}
