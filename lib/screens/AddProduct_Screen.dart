import 'dart:io';

import 'package:anybuy/provider/MerchantData_Provider.dart';
import 'package:anybuy/widgets/AppHeader.dart';
import 'package:anybuy/widgets/ImagePicker.dart';
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
  File _imagePick;

  void _imagePicked(File image) {
    _imagePick = image;
  }

  final _addProductFormKey = GlobalKey<FormState>();

  TextEditingController _productNameController = TextEditingController();
  TextEditingController _countController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  String proName = "";
  double countInStock;
  double price;

  FocusNode _name;
  FocusNode _count;
  FocusNode _price;
  FocusNode _add;

  @override
  void initState() {
    super.initState();
    _name = FocusNode();
    _count = FocusNode();
    _price = FocusNode();
    _add = FocusNode();
  }

  @override
  void dispose() {
    _productNameController.clear();
    _countController.clear();
    _priceController.clear();

    _name.dispose();
    _count.dispose();
    _price.dispose();
    _add.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final merchantData = Provider.of<MerchantData>(context);

    void validate() async {
      if (!_addProductFormKey.currentState.validate()) {
        // print("Invalid");
        return;
      }
      _addProductFormKey.currentState.save();
      if (_imagePick == null)
        errorDialog(context, "Submit An Image");
      else {
        await merchantData.addProduct(
          ctx: context,
          proName: proName,
          image: _imagePick,
          count: countInStock,
          price: price,
        );
        _productNameController.clear();
        _countController.clear();
        _priceController.clear();
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
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
                ImgPicker(_imagePicked),
                Form(
                  key: _addProductFormKey,
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: TextFormField(
                            controller: _productNameController,
                            focusNode: _name,
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
                            onFieldSubmitted: (String value) {
                              proName = value;
                              _name.unfocus();
                              FocusScope.of(context).requestFocus(_count);
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
                            controller: _countController,
                            focusNode: _count,
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
                            onFieldSubmitted: (String value) {
                              countInStock = double.parse(value);
                              _count.unfocus();
                              FocusScope.of(context).requestFocus(_price);
                            },
                            onSaved: (newValue) {
                              setState(() {
                                countInStock = double.parse(newValue);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: TextFormField(
                            controller: _priceController,
                            focusNode: _price,
                            decoration: inpDec(
                              "Price in INR",
                              "Price",
                            ),
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Required";
                              }
                              return null;
                            },
                            keyboardType: TextInputType.number,
                            onFieldSubmitted: (String value) {
                              price = double.parse(value);
                              _price.unfocus();
                              FocusScope.of(context).requestFocus(_add);
                            },
                            onSaved: (val) {
                              setState(() {
                                price = double.parse(val);
                              });
                            },
                          ),
                        ),
                        TextButton.icon(
                          focusNode: _add,
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
