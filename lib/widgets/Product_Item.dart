import 'package:flutter/material.dart';

import '../constants.dart';

class ProductItem extends StatelessWidget {
  final String proId;
  final String proName;
  final double countInStock;
  final double price;

  ProductItem({
    @required this.proId,
    @required this.proName,
    @required this.countInStock,
    @required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Container(
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
          height: 40,
          width: 40,
        ),
        title: Text(proName),
        subtitle: Text(
          "Count in stock: $countInStock",
        ),
        trailing: IconButton(
          icon: Icon(Icons.edit_outlined),
          onPressed: () {},
        ),
      ),
    );
  }
}
