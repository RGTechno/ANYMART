import 'package:anybuy/provider/Outlet_Provider.dart';
import 'package:anybuy/widgets/AppHeader.dart';
import 'package:anybuy/widgets/Outlet_Item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final outletData = Provider.of<OutletData>(context);

    final categoryArgs = ModalRoute.of(context).settings.arguments as Map;
    final String cat = categoryArgs["category"];
    return Scaffold(
      appBar: appHeader(context),
      body: FutureBuilder(
        future: outletData.getOutletsByCategory(cat),
        builder: (ctx, snapshot) {
          var sd = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting ||
              sd == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return sd.length == 0
              ? Center(
                  child: Text("No Outlets for this category at the moment"),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return OutletItem(
                      outletName: sd[index][outletName],
                      id: sd[index][outletId],
                      category: sd[index][category],
                      outletImage: sd[index][outletImg],
                    );
                  },
                  itemCount: sd.length,
                );
        },
      ),
    );
  }
}
