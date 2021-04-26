import 'package:flutter/material.dart';

class UserCartItem extends StatelessWidget {
  final String id;
  final String productId;
  final String productName;
  final double price;
  final int quantity;
  final double count;
  final String proImg;

  UserCartItem({
    @required this.id,
    @required this.productId,
    @required this.productName,
    @required this.price,
    @required this.quantity,
    @required this.count,
    @required this.proImg,
  });

  @override
  Widget build(BuildContext context) {
    double totalItemPrice = price * quantity;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 3),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: Colors.blue),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                proImg,
                height: 75,
                width: 75,
                fit: BoxFit.cover,
              ),
            ),
            height: 75,
            width: 75,
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("\u{20B9}$price"),
                  Text("Quantity: ${quantity}X"),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              "\u{20B9}$totalItemPrice",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
