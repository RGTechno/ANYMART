import 'package:anybuy/provider/Cart_Provider.dart';
import 'package:anybuy/widgets/cartCounter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class UserProductItem extends StatelessWidget {
  final String productId;
  final String productName;
  final double productPrice;
  final String image;
  final String category;

  // TODO:final String productDescription;

  UserProductItem({
    @required this.productId,
    @required this.productName,
    @required this.productPrice,
    @required this.image,
    @required this.category,
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
                  child: Image.network(
                    image,
                    height: 500,
                    width: 500,
                    fit: BoxFit.cover,
                  ),
                  height: 100,
                  width: 100,
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
              onPressed: () {
                showModal(
                  context,
                  productName,
                  productPrice,
                  image,
                  category,
                );
              },
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
              showModal(
                context,
                productName,
                productPrice,
                image,
                category,
              );
            },
          ),
          height: 100,
        ),
        Divider(thickness: 2),
      ],
    );
  }
}

void showModal(
  BuildContext ctx,
  String name,
  double price,
  String img,
  String productCat,
) {
  final cartData = Provider.of<CartData>(ctx, listen: false);

  showModalBottomSheet<void>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
    ),
    context: ctx,
    builder: (BuildContext context) {
      return Container(
        height: 650,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                        Text(
                          "\u{20B9}$price",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                    flex: 3,
                  ),
                  Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        img,
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 100,
                    width: 100,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CartCounter(),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                          color3,
                        ),
                      ),
                      onPressed: () {
                        cartData.addToCart(
                          ctx,
                          {
                            productName: name,
                            productPrice: price,
                            productImg: img,
                            "Quantity": CartCounter.qty,
                          },
                          productCat,
                        );
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.add_shopping_cart_rounded),
                      label: Text("Add Item"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
