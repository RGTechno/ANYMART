import 'package:anybuy/constants.dart';
import 'package:anybuy/provider/Outlet_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/Drawer.dart';
import '../widgets/Categories.dart';
import '../widgets/Search.dart';

class UserHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final outletData = Provider.of<OutletData>(context);
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
        body: FutureBuilder(
          future: outletData.getAllOutlets(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  SearchBar(),
                  Categories(),
                  ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (ctx, index) {
                      return Center(
                        child: Text(snapshot.data[index][outletName]),
                      );
                    },
                    itemCount: snapshot.data.length,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
