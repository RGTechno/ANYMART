import 'package:anybuy/constants.dart';
import 'package:anybuy/provider/Outlet_Provider.dart';
import 'package:anybuy/widgets/AppHeader.dart';
import 'package:anybuy/widgets/Outlet_Item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/Categories.dart';
import '../widgets/Drawer.dart';

class UserHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final outletData = Provider.of<OutletData>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        drawer: new DrawerMenu(),
        appBar: appHeader(context),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Explore Categories",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Categories(),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Discover Outlets",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (ctx, index) {
                      return OutletItem(
                        outletName: sd[index][outletName],
                        id: sd[index][outletId],
                        category: sd[index][category],
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
