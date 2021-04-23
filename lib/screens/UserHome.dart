import 'package:anybuy/constants.dart';
import 'package:anybuy/provider/Outlet_Provider.dart';
import 'package:anybuy/widgets/Outlet_Item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/Categories.dart';
import '../widgets/Drawer.dart';
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
            var sd = snapshot.data;
            return SingleChildScrollView(
              child: Column(
                children: [
                  SearchBar(),
                  Categories(),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return OutletItem(
                        outletName: sd[index][outletName],
                        id: sd[index][outletId],
                      );
                    },
                    itemCount: sd.length,
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
