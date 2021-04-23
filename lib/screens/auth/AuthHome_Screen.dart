import 'dart:ui';

import 'package:anybuy/constants.dart';
import 'package:anybuy/provider/AuthData_Provider.dart';
import 'package:anybuy/widgets/AppHeader.dart';
import 'package:anybuy/widgets/InputFieldDec.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AuthHome extends StatefulWidget {
  @override
  _AuthHomeState createState() => _AuthHomeState();
}

class _AuthHomeState extends State<AuthHome> {
  final _authHomeKey = GlobalKey<FormState>();

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String userEmail = "";
  String userPass = "";
  String firstName = "";
  String lastName = "";
  bool wantSignup = false;

  FocusNode _email;
  FocusNode _password;
  FocusNode _firstName;
  FocusNode _lastName;
  FocusNode _create;

  @override
  void initState() {
    super.initState();
    _email = FocusNode();
    _password = FocusNode();
    _firstName = FocusNode();
    _lastName = FocusNode();
    _create = FocusNode();
  }

  @override
  void dispose() {
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _passwordController.clear();

    _email.dispose();
    _password.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _create.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthData>(context);
    void validate() async {
      if (!_authHomeKey.currentState.validate()) {
        print("Invalid");
        return;
      }
      _authHomeKey.currentState.save();
      if (!wantSignup) {
        await authData.login(userEmail, userPass, context);
        if (authData.currentUserData.isNotEmpty)
          await Navigator.of(context).pushReplacementNamed(homeScreen);
      } else {
        authData.createUser(
          email: userEmail,
          pass: userPass,
          firstname: firstName,
          lastname: lastName,
          ctx: context,
        );
        _firstNameController.clear();
        _lastNameController.clear();
        _emailController.clear();
        _passwordController.clear();
      }
    }

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: appHeader(context),
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ListTile(
                  subtitle: InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed(merchAuth);
                    },
                    child: Text(
                      "Are You A Merchant?, Click Here",
                      style: GoogleFonts.architectsDaughter(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    "HI! User",
                    style: GoogleFonts.architectsDaughter(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Form(
                  key: _authHomeKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      wantSignup
                          ? Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextFormField(
                                controller: _firstNameController,
                                focusNode: _firstName,
                                decoration: inpDec(
                                  "First Name",
                                  "First Name",
                                ),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Required";
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (String value) {
                                  firstName = value;
                                  _firstName.unfocus();
                                  FocusScope.of(context)
                                      .requestFocus(_lastName);
                                },
                                onSaved: (newValue) {
                                  setState(() {
                                    firstName = newValue;
                                  });
                                },
                              ),
                            )
                          : Container(),
                      wantSignup
                          ? Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextFormField(
                                controller: _lastNameController,
                                focusNode: _lastName,
                                decoration: inpDec(
                                  "Last Name",
                                  "Last Name",
                                ),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Required";
                                  }
                                  return null;
                                },
                                onFieldSubmitted: (String value) {
                                  lastName = value;
                                  _lastName.unfocus();
                                  FocusScope.of(context).requestFocus(_email);
                                },
                                onSaved: (newValue) {
                                  setState(() {
                                    lastName = newValue;
                                  });
                                },
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextFormField(
                          controller: _emailController,
                          focusNode: _email,
                          decoration: inpDec(
                            "Enter Email-ID",
                            "Email",
                          ),
                          validator: (String value) {
                            if (value.isEmpty || !value.contains("@")) {
                              return "Invalid";
                            }
                            return null;
                          },
                          onFieldSubmitted: (String value) {
                            userEmail = value;
                            _email.unfocus();
                            FocusScope.of(context).requestFocus(_password);
                          },
                          onSaved: (newValue) {
                            setState(() {
                              userEmail = newValue;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextFormField(
                          controller: _passwordController,
                          focusNode: _password,
                          decoration: inpDec(
                            "Enter Password",
                            "Password",
                          ),
                          obscureText: true,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Required";
                            }
                            if (value.length < 5) {
                              return "Password should be more than 5 characters";
                            }
                            return null;
                          },
                          onFieldSubmitted: (String value) {
                            userPass = value;
                            _password.unfocus();
                            FocusScope.of(context).requestFocus(_create);
                          },
                          onSaved: (newValue) {
                            setState(() {
                              userPass = newValue;
                            });
                          },
                        ),
                      ),
                      TextButton.icon(
                        focusNode: _create,
                        onPressed: validate,
                        icon: Icon(
                          !wantSignup
                              ? Icons.login_rounded
                              : Icons.app_registration,
                          color: Colors.black54,
                        ),
                        label: Text(
                          !wantSignup ? "Login" : "Create",
                          style: GoogleFonts.poppins(
                            color: Colors.black54,
                          ),
                        ),
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
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            wantSignup = !wantSignup;
                          });
                        },
                        child: !wantSignup
                            ? Text(
                                "New User! Sign Up Here",
                                style: GoogleFonts.poppins(
                                  color: Colors.black54,
                                ),
                              )
                            : Text(
                                "Already a member!,Login Here",
                                style: GoogleFonts.poppins(
                                  color: Colors.black54,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
