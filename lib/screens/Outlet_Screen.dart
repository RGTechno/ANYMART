import 'package:anybuy/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/Outlet_Provider.dart';

class Outlet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final outletData = Provider.of<OutletData>(context);

    final outletId = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black87,
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
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
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return Center(
                      child: Text(sdp[index]["productName"]),
                    );
                  },
                  itemCount: sdp.length,
                );
        },
      ),
    );
  }
}
