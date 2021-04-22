import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';

class UserProductItem extends StatelessWidget {
  final String productId;
  final String productName;
  final double productPrice;

  UserProductItem({
    @required this.productId,
    @required this.productName,
    @required this.productPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: ListTile(
            title: Text(
              productName,
              overflow: TextOverflow.fade,
              softWrap: true,
            ),
            trailing: Stack(
              children: [
                Container(
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
                  ),
                  height: 50,
                  width: 50,
                ),
              ],
            ),
            subtitle: Text(
              "\u{20B9}$productPrice",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.add,
                color: Colors.black54,
              ),
              label: Text(
                "ADD",
                style: GoogleFonts.poppins(
                  color: Colors.black54,
                ),
              ),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(
                      color: Colors.black54,
                    ),
                  ),
                ),
              ),
            ),
            onTap: () {
              print(productId);
            },
          ),
          height: 100,
        ),
        Divider(thickness: 2),
      ],
    );
  }
}
