import 'package:flutter/material.dart';

import '../constants.dart';

class OutletHeader extends StatelessWidget {
  final String outletName;

  OutletHeader({@required this.outletName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(
              0.5,
              2.0,
            ),
          ),
        ],
      ),
      width: double.infinity,
      height: 180,
      child: Stack(
        children: [
          ListTile(
            title: Text(
              outletName,
              overflow: TextOverflow.fade,
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            subtitle: Text(
              "Address",
              style: TextStyle(
                fontSize: 13,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 5,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.mail_outline_rounded),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.phone_enabled_rounded),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.location_on_outlined),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          Positioned(
            right: 15,
            top: 12.7,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: [
                    color3,
                    color4,
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              height: 100,
              width: 100,
            ),
          ),
        ],
      ),
    );
  }
}
