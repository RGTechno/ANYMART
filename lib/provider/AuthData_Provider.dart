import 'package:anybuy/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthData with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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

  Future<void> createOutlet(
    String id,
    String name,
    String inputOutletName,
    String cat,
  ) async {
    try {
      await firestore.collection("/$outletsCollection").add({
        merchantId: id,
        merchantName: name,
        outletName: inputOutletName,
        category: cat,
        products: [],
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

  void createMerchant({
    @required String email,
    @required String pass,
    @required String firstname,
    @required String lastname,
    @required String outletName,
    @required String category,
    BuildContext ctx,
  }) async {
    print("create user running");
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
