import 'package:flutter/material.dart';

import '../widgets/Drawer.dart';
import '../widgets/Categories.dart';
import '../widgets/Search.dart';

class UserHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        drawer: DrawerMenu(),
        appBar: AppBar(
          title: Text(
            "ANYBUY",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 40,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          iconTheme: IconThemeData(
            color: Colors.black87,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SearchBar(),
              Categories(),
            ],
          ),
        ),
      ),
    );
  }
}
