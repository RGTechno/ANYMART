import 'package:anybuy/provider/AuthData_Provider.dart';
import 'package:anybuy/provider/Cart_Provider.dart';
import 'package:anybuy/provider/Order_Provider.dart';
import 'package:anybuy/widgets/AppHeader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class PlaceOrderScreen extends StatefulWidget {
  @override
  _PlaceOrderScreenState createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  bool _isLoading = false;
  String selectedAddress;

  double currentLatitude;
  double currentLongitude;
  String address;

  Future<void> getAddress() async {
    final coordinates = new Coordinates(currentLatitude, currentLongitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    setState(() {
      address = addresses.first.addressLine;
    });
  }

  Future<void> _determineAndSetPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    final location = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      currentLatitude = location.latitude;
      currentLongitude = location.longitude;
    });

    await getAddress();

    // print(address);
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthData>(context);
    final orderData = Provider.of<OrdersData>(context);
    final cartData = Provider.of<CartData>(context);

    print(selectedAddress);

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
              appBar: appHeader(context),
              body: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            color3,
                            color4,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      child: TextButton.icon(
                        onPressed: () {
                          _determineAndSetPosition();
                        },
                        icon: Icon(
                          Icons.my_location,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Deliver To Current Location",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   padding: const EdgeInsets.all(5),
                    //   margin: const EdgeInsets.symmetric(
                    //     horizontal: 5,
                    //     vertical: 5,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: Colors.white,
                    //     boxShadow: [
                    //       BoxShadow(
                    //           color: Colors.black,
                    //           blurRadius: 1,
                    //           offset: Offset(0.2, 0.5),
                    //           spreadRadius: 0.5),
                    //     ],
                    //
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     children: [
                    //       Text("Credit/Debit Card"),
                    //       TextField(
                    //         decoration: InputDecoration(
                    //           hintText: "Card Number",
                    //           labelText: "Card Number",
                    //         ),
                    //       ),
                    //       TextField(
                    //         decoration: InputDecoration(
                    //           hintText: "Validity",
                    //           labelText: "Validity",
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26, width: 1),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Deliver To:",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              fontSize: 15,
                            ),
                          ),
                          Divider(thickness: 1.5),
                          address != null
                              ? RadioListTile(
                                  toggleable: true,
                                  groupValue: selectedAddress,
                                  value: address,
                                  title: Text(address),
                                  onChanged: (String value) {
                                    setState(() {
                                      selectedAddress = value;
                                    });
                                  },
                                )
                              : Container(),
                          authData.currentUserData["location"] != ""
                              ? Container(
                                  child: RadioListTile(
                                    toggleable: true,
                                    groupValue: selectedAddress,
                                    value:
                                        "${authData.currentUserData["location"]}",
                                    onChanged: (String value) {
                                      setState(() {
                                        selectedAddress = value;
                                      });
                                    },
                                    title: Text(
                                      authData.currentUserData["location"],
                                    ),
                                  ),
                                )
                              : Column(
                                  children: [
                                    Container(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          hintText: "Enter Delivery Location",
                                          labelText: "Delivery Location",
                                        ),
                                        maxLines: null,
                                        keyboardType: TextInputType.multiline,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed(profileScreen);
                                        },
                                        child: Text(
                                          "OR Set Your Default Location in Profile",
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        await orderData.placeOrder(
                            ctx: context,
                            cartProducts: cartData.cartItems.values.toList(),
                            orderAmount: cartData.totalAmountWithDelivery,
                            outletID: cartData.cartOutletId,
                            location: selectedAddress,
                            phone: authData.currentUserData["phoneNumber"],
                            orderHandler: () {
                              cartData.clearCart();

                              Navigator.of(context)
                                  .pushReplacementNamed(afterOrderScreen);
                            });
                        setState(() {
                          _isLoading = false;
                        });

                        // print(authData.currentUserData["orders"]);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        margin:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 15),
                        height: 50,
                        width: double.infinity,
                        child: Text(
                          "Place Order",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              color3,
                              color4,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
