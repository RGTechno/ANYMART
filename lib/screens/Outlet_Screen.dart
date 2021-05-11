import 'package:anybuy/constants.dart';
import 'package:anybuy/widgets/AppHeader.dart';
import 'package:anybuy/widgets/OutletHeader.dart';
import 'package:anybuy/widgets/UserProduct_Item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/Outlet_Provider.dart';

class Outlet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final outletData = Provider.of<OutletData>(context);

    final outletId = ModalRoute.of(context).settings.arguments as String;

    return Scaffold(
      appBar: appHeader(context),
      body: FutureBuilder(
        future: outletData.getOutletById(outletId),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var sdp = snapshot.data[products];

          return sdp.length == 0
              ? Center(
                  child: Text("No Products For This Outlet"),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OutletHeader(
                        outletDetails: outletData.outletMerchant,
                        outletName: snapshot.data[outletName],
                        outletImage: snapshot.data[outletImg],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          "Recommended",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return UserProductItem(
                            productId: sdp[index][productId],
                            productName: sdp[index][productName],
                            productPrice: double.parse(
                              sdp[index][productPrice].toString(),
                            ),
                            image: sdp[index][productImg],
                            category: snapshot.data[category],
                            count: double.parse(
                              sdp[index][countInStock].toString(),
                            ),
                            outletId: outletId,
                          );
                        },
                        itemCount: sdp.length,
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
