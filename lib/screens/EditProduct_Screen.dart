import 'package:anybuy/constants.dart';
import 'package:anybuy/provider/MerchantData_Provider.dart';
import 'package:anybuy/widgets/InputFieldDec.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _editProductFormKey = GlobalKey<FormState>();
  bool _isLoading = false;

  String phone = "";
  String location = "";
  String firstName = "";
  String lastName = "";
  bool wantSignup = false;

  FocusNode _phone;
  FocusNode _location;
  FocusNode _firstName;
  FocusNode _lastName;
  FocusNode _update;

  @override
  void initState() {
    super.initState();
    _phone = FocusNode();
    _location = FocusNode();
    _firstName = FocusNode();
    _lastName = FocusNode();
    _update = FocusNode();
  }

  @override
  void dispose() {
    _phone.dispose();
    _location.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _update.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final proID = ModalRoute.of(context).settings.arguments as String;
    final currentDetails =
        Provider.of<MerchantData>(context).currentUserProduct;
    var merchantProducts = [...currentDetails[products]];
    var product =
        merchantProducts.where((element) => element[productId] == proID);
    var editableProduct = product.toList()[0];
    return _isLoading
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    icon: Icon(Icons.save_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Form(
                  key: _editProductFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5.0,
                                vertical: 10,
                              ),
                              child: TextFormField(
                                focusNode: _firstName,
                                decoration:
                                    inpDec("Product Name", "Product Name"),
                                initialValue: "${editableProduct[productName]}",
                                onFieldSubmitted: (String value) {
                                  firstName = value;
                                  _firstName.unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(_lastName);
                                },
                                onSaved: (String updatedValue) {
                                  setState(() {
                                    firstName = updatedValue;
                                  });
                                },
                              ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 5.0,
                                vertical: 10,
                              ),
                              child: TextFormField(
                                focusNode: _lastName,
                                decoration:
                                    inpDec("Count In Stock", "Count In Stock"),
                                initialValue:
                                    "${editableProduct[countInStock]}",
                                onFieldSubmitted: (String value) {
                                  lastName = value;
                                  _lastName.unfocus();
                                  FocusScope.of(context).requestFocus(_phone);
                                },
                                keyboardType: TextInputType.number,
                                onSaved: (String updatedValue) {
                                  setState(() {
                                    lastName = updatedValue;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                          vertical: 10,
                        ),
                        child: TextFormField(
                          focusNode: _phone,
                          decoration: inpDec("price", "price"),
                          initialValue: "${editableProduct[productPrice]}",
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Field is Required";
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          onFieldSubmitted: (String value) {
                            phone = value;
                            _phone.unfocus();
                            FocusScope.of(context).requestFocus(_location);
                          },
                          onSaved: (String updatedValue) {
                            setState(() {
                              phone = updatedValue;
                            });
                          },
                        ),
                      ),
                      OutlinedButton.icon(
                        focusNode: _update,
                        style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                            EdgeInsets.symmetric(horizontal: 20),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                              side: BorderSide(
                                color: Colors.black54,
                              ),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        icon: Icon(
                          Icons.save_outlined,
                        ),
                        label: Text("Update"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
