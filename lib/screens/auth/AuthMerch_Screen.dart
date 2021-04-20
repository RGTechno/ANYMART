import 'package:anybuy/constants.dart';
import 'package:anybuy/widgets/InputFieldDec.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anybuy/provider/AuthData_Provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/Categories.dart';

class AuthMerchant extends StatefulWidget {
  @override
  _AuthMerchantState createState() => _AuthMerchantState();
}

class _AuthMerchantState extends State<AuthMerchant> {
  final _authMerchantKey = GlobalKey<FormState>();
  String merchEmail = "";
  String merchPass = "";
  String merchFirstName = "";
  String merchLastName = "";
  String outletName = "";
  String category;
  bool wantSignup = false;

  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthData>(context);
    void validate() async {
      if (!_authMerchantKey.currentState.validate()) {
        print("Invalid");
        return;
      }
      _authMerchantKey.currentState.save();
      if (!wantSignup) {
        await authData.login(merchEmail, merchPass);
        if (authData.currentUserData.isNotEmpty)
          await Navigator.of(context).pushReplacementNamed(homeScreen);
      } else {
        authData.createMerchant(
          email: merchEmail,
          pass: merchPass,
          firstname: merchFirstName,
          lastname: merchLastName,
          outletName: outletName,
          category: category,
        );
      }
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
                  key: _authMerchantKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      wantSignup
                          ? Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextFormField(
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
                                onSaved: (newValue) {
                                  setState(() {
                                    merchFirstName = newValue;
                                  });
                                },
                              ),
                            )
                          : Container(),
                      wantSignup
                          ? Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextFormField(
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
                                onSaved: (newValue) {
                                  setState(() {
                                    merchLastName = newValue;
                                  });
                                },
                              ),
                            )
                          : Container(),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextFormField(
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
                          onSaved: (newValue) {
                            setState(() {
                              merchEmail = newValue;
                            });
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: TextFormField(
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
                          onSaved: (newValue) {
                            setState(() {
                              merchPass = newValue;
                            });
                          },
                        ),
                      ),
                      wantSignup
                          ? Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: TextFormField(
                                decoration: inpDec(
                                  "Outlet Name",
                                  "Outlet Name",
                                ),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return "Required";
                                  }
                                  return null;
                                },
                                onSaved: (newValue) {
                                  setState(() {
                                    outletName = newValue;
                                  });
                                },
                              ),
                            )
                          : Container(),
                      wantSignup
                          ? Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: DropdownButtonFormField(
                                value: category,
                                decoration: inpDec(
                                  "Category",
                                  "Select Category",
                                ),
                                items: Categories.catMap == null
                                    ? null
                                    : Categories.catMap.map(
                                        (cat) {
                                          return new DropdownMenuItem(
                                            child: new Text(cat["category"]),
                                            value: cat["category"],
                                          );
                                        },
                                      ).toList(),
                                onChanged: (newValue) {
                                  setState(() {
                                    category = newValue;
                                  });
                                },
                              ),
                            )
                          : Container(),
                      TextButton.icon(
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
