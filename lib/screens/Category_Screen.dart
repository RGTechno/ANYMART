import 'package:anybuy/provider/Outlet_Provider.dart';
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
      appBar: AppBar(
        title: Text(
          "${categoryArgs["category"]}",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
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
                    return OutletItem(sd[index][outletName]);
                  },
                  itemCount: sd.length,
                );
        },
      ),
    );
  }
}
