import 'package:flutter/material.dart';

class OutletHeader extends StatelessWidget {
  final String outletName;
  final String outletImage;

  OutletHeader({
    @required this.outletName,
    this.outletImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
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
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  outletImage,
                  height: 150,
                  width: 120,
                  fit: BoxFit.cover,
                ),
              ),
              height: 150,
              width: 120,
            ),
          ),
        ],
      ),
    );
  }
}
