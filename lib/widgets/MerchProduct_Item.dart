import 'package:flutter/material.dart';

class MerchantProductItem extends StatelessWidget {
  final String proId;
  final String proName;
  final double countInStock;
  final double price;
  final String image;

  MerchantProductItem({
    @required this.proId,
    @required this.proName,
    @required this.countInStock,
    @required this.price,
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ListTile(
        leading: Container(
          child: Image.network(
            image,
            fit: BoxFit.cover,
          ),
          height: 100,
          width: 100,
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
