import 'package:anybuy/provider/AuthData_Provider.dart';
import 'package:anybuy/widgets/InputFieldDec.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _profileFormKey = GlobalKey<FormState>();
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
    final authData = Provider.of<AuthData>(context);
    final currentUserData = authData.currentUserData;

    void _updateDetails() async {
      if (!_profileFormKey.currentState.validate()) {
        print("Invalid");
        return;
      }
      _profileFormKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
      await authData.updateAccountDetails(
        firstname: firstName,
        lastname: lastName,
        location: location,
        phoneNo: phone,
      );
      setState(() {
        _isLoading = false;
      });
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
                  key: _profileFormKey,
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
                                decoration: inpDec("firstname", "firstname"),
                                initialValue: "${currentUserData["firstname"]}",
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
                                decoration: inpDec("lastname", "lastname"),
                                initialValue: "${currentUserData["lastname"]}",
                                onFieldSubmitted: (String value) {
                                  lastName = value;
                                  _lastName.unfocus();
                                  FocusScope.of(context).requestFocus(_phone);
                                },
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
                          decoration: inpDec("Phone", "Phone No."),
                          initialValue: currentUserData["phoneNumber"] != null
                              ? "${currentUserData["phoneNumber"]}"
                              : "",
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
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5.0,
                          vertical: 10,
                        ),
                        child: TextFormField(
                          focusNode: _location,
                          decoration:
                              inpDec("Set Default Home location", "location"),
                          initialValue: currentUserData["location"] != null
                              ? "${currentUserData["location"]}"
                              : "",
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          onFieldSubmitted: (String value) {
                            location = value;
                            _location.unfocus();
                            FocusScope.of(context).requestFocus(_update);
                          },
                          onSaved: (String updatedValue) {
                            setState(() {
                              location = updatedValue;
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
