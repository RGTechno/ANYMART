import 'package:anybuy/provider/MerchantData_Provider.dart';
import 'package:anybuy/screens/EditProduct_Screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    final merchantData = Provider.of<MerchantData>(context, listen: false);

    return Card(
      elevation: 5,
      child: Row(
        children: [
          Container(
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
            height: 100,
            width: 100,
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    proName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Count in stock: $countInStock",
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => EditProductScreen(),
                  settings: RouteSettings(arguments: proId),
                ),
              );
            },
          ),
          IconButton(
              icon: Icon(Icons.delete_outline_rounded),
              onPressed: () {
                merchantData.deleteProduct(
                  productId: proId,
                  proName: proName,
                  productImageUrl: image,
                  count: countInStock,
                  price: price,
                );
              }),
        ],
      ),
    );
  }
}
