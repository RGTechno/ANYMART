import 'package:flutter/material.dart';

import '../constants.dart';

class OutletItem extends StatelessWidget {
  final String id;
  final String outletName;
  final String category;

  OutletItem({
    @required this.outletName,
    @required this.id,
    @required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          outletScreen,
          arguments: id,
        );
      },
      child: ClipRRect(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomRight,
                        colors: [
                          color3,
                          color4,
                        ],
                      ),
                    ),
                    width: double.infinity,
                    height: 200,
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      icon: Icon(
                        Icons.favorite_border_rounded,
                        color: Colors.white,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              ListTile(
                title: Text(
                  outletName,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("4.1"),
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                  ],
                ),
                subtitle: Text(category),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
