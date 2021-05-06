import 'package:anybuy/constants.dart';
import 'package:anybuy/provider/AuthData_Provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authData = Provider.of<AuthData>(context);
    var user;
    final currentUserData = authData.currentUserData;
    if (currentUserData.isNotEmpty) {
      user = authData.auth.currentUser;
      // print(user.uid + user.email);
      // authData.getCurrentUserData("users", "${user.uid}");
      print(currentUserData["firstname"]);
    } else {
      print("No user Signed in!!");
    }
    return Drawer(
      elevation: 0,
      child: ListView(
        children: [
          DrawerHeader(
            duration: Duration(
              milliseconds: 300,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  color1,
                  color2,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text(
                    user == null
                        ? "Welcome User"
                        : "Welcome ${currentUserData["firstname"]}",
                    style: GoogleFonts.architectsDaughter(
                      fontWeight: FontWeight.w500,
                      fontSize: 25,
                    ),
                  ),
                  subtitle: Text(
                    currentUserData["isMerchant"] == true && user != null
                        ? "Merchant"
                        : "",
                    style: GoogleFonts.poppins(
                      fontSize: 11.5,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    user == null
                        ? Navigator.of(context).pushNamed(authHome)
                        : await authData.signOut(context);
                  },
                  child: Text(
                    user == null ? "Login/Signup" : "Logout",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.symmetric(horizontal: 20),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          user == null
              ? ListTile(
                  leading: Icon(Icons.person_add_alt_1_rounded),
                  title: Text(
                    "ANYBUY Buisness",
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(merchAuth);
                  },
                )
              : Container(),
          currentUserData["isMerchant"] == true && user != null
              ? ListTile(
                  leading: Icon(Icons.add),
                  title: Text(
                    "Add Product",
                    style: TextStyle(fontSize: 16),
                  ),
                  onTap: () {
                    Navigator.of(context).pushNamed(addProduct);
                  },
                )
              : Container(),
          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text(
              "Profile",
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              if(currentUserData.isEmpty){
                Navigator.of(context).pushNamed(authHome);
              }
              else Navigator.of(context).pushNamed(profileScreen);
            },
          ),
          ListTile(
            leading: Icon(Icons.pending_actions_rounded),
            title: Text(
              "Orders",
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              if(currentUserData.isEmpty){
                Navigator.of(context).pushNamed(authHome);
              }
              else Navigator.of(context).pushNamed(ordersScreen);
            },
          ),
        ],
      ),
    );
  }
}
