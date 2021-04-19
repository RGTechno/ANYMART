import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    String outletName,
    String cat,
  ) async {
    try {
      await firestore.collection("/outlets").add({
        "merchantId": id,
        "merchantName": name,
        "outletName": outletName,
        "category": cat,
      });
    } catch (err) {
      print(err);
    }
  }

  void createUser({
    @required String email,
    @required String pass,
    @required String firstname,
    @required String lastname,
  }) async {
    print("create user running");
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      await firestore
          .collection("allUsers")
          .doc("${userCredential.user.uid}")
          .set({
        "id": "${userCredential.user.uid}",
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "initials": "${firstname[0].toUpperCase()}${lastname[0].toUpperCase()}",
      });

      await firestore
          .collection("users")
          .doc("${userCredential.user.uid}")
          .set({
        "id": "${userCredential.user.uid}",
        "firstname": firstname,
        "lastname": lastname,
        "email": email,
        "initials": "${firstname[0].toUpperCase()}${lastname[0].toUpperCase()}",
      });

      print(
        "User Created ${userCredential.user.email}, ${userCredential.user.uid}",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  void createMerchant({
    @required String email,
    @required String pass,
    @required String firstname,
    @required String lastname,
    @required String outletName,
    @required String category,
  }) async {
    print("create user running");
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );

      await firestore
          .collection("allUsers")
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
          .collection("merchant")
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

      print(
        "User Created ${userCredential.user.email}, ${userCredential.user.uid}",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> login(String email, String pass) async {
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
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future<void> signOut(BuildContext ctx) async {
    await auth.signOut();
    _currentUserData.clear();

    Navigator.of(ctx).pop();
    notifyListeners();
  }

  Future<void> getCurrentUserData({String collection = "allUsers"}) async {
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
