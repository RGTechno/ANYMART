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

  double price;
  String proName = "";
  double stockCount;

  FocusNode _price;
  FocusNode _name;
  FocusNode _count;
  FocusNode _update;

  @override
  void initState() {
    super.initState();
    _price = FocusNode();
    _name = FocusNode();
    _count = FocusNode();
    _update = FocusNode();
  }

  @override
  void dispose() {
    _price.dispose();
    _name.dispose();
    _count.dispose();
    _update.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final proID = ModalRoute.of(context).settings.arguments as String;
    final merchantData = Provider.of<MerchantData>(context);
    final currentDetails = merchantData.currentUserProduct;
    var merchantProducts = [...currentDetails[products]];
    var product =
        merchantProducts.where((element) => element[productId] == proID);
    var editableProduct = product.toList()[0];

    void _updateDetails() async {
      if (!_editProductFormKey.currentState.validate()) {
        print("Invalid");
        return;
      }
      _editProductFormKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
      await merchantData.updateProduct(
        id: proID,
        price: price,
        count: stockCount,
        proName: proName,
      );
      setState(() {
        _isLoading = false;
      });
      // Navigator.of(context).pop();
    }

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
                    onPressed: _updateDetails,
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
                                focusNode: _name,
                                decoration:
                                    inpDec("Product Name", "Product Name"),
                                initialValue: "${editableProduct[productName]}",
                                onFieldSubmitted: (String value) {
                                  proName = value;
                                  _name.unfocus();
                                  FocusScope.of(context).requestFocus(_count);
                                },
                                onSaved: (String updatedValue) {
                                  setState(() {
                                    proName = updatedValue;
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
                                focusNode: _count,
                                decoration:
                                    inpDec("Count In Stock", "Count In Stock"),
                                initialValue:
                                    "${editableProduct[countInStock]}",
                                onFieldSubmitted: (String value) {
                                  stockCount = double.parse(value);
                                  _count.unfocus();
                                  FocusScope.of(context).requestFocus(_price);
                                },
                                keyboardType: TextInputType.number,
                                onSaved: (String updatedValue) {
                                  setState(() {
                                    stockCount = double.parse(updatedValue);
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
                          focusNode: _price,
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
                            price = double.parse(value);
                            _price.unfocus();
                            FocusScope.of(context).requestFocus(_update);
                          },
                          onSaved: (String updatedValue) {
                            setState(() {
                              price = double.parse(updatedValue);
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
                        onPressed: _updateDetails,
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
