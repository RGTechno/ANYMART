import 'package:anybuy/provider/AuthData_Provider.dart';
import 'package:anybuy/provider/MerchantData_Provider.dart';
import 'package:anybuy/widgets/InputFieldDec.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _addProductFormKey = GlobalKey<FormState>();

  String proName = "";
  double countInStock;

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthData>(context);
    final user = authData.auth.currentUser;
    final merchantData = Provider.of<MerchantData>(context);

    void validate() async {
      if (!_addProductFormKey.currentState.validate()) {
        print("Invalid");
        return;
      }
      _addProductFormKey.currentState.save();
      await merchantData.addProduct(
        user.uid,
        {
          "productName": proName,
          "countInStock": countInStock,
        },
      );
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black87,
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                color2,
                color1,
              ],
              stops: [0.85, 0.1],
            ),
          ),
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          // margin: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Form(
                  key: _addProductFormKey,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: TextFormField(
                            decoration: inpDec(
                              "Product Name",
                              "Product Name",
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Required";
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              setState(() {
                                proName = newValue;
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: TextFormField(
                            decoration: inpDec(
                              "Count In Stock",
                              "Count In Stock",
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Required";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            onSaved: (newValue) {
                              setState(() {
                                countInStock = double.parse(newValue);
                              });
                            },
                          ),
                        ),
                        TextButton.icon(
                          onPressed: validate,
                          icon: Icon(
                            Icons.add,
                            color: Colors.black54,
                          ),
                          label: Text(
                            "Add Product",
                            style: GoogleFonts.poppins(
                              color: Colors.black54,
                            ),
                          ),
                          style: ButtonStyle(
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              EdgeInsets.symmetric(horizontal: 20),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                                side: BorderSide(
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
