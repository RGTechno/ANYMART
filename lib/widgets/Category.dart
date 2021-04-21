import 'package:anybuy/constants.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  String id;
  String imageUrl;
  String catName;

  Category({
    @required this.id,
    @required this.imageUrl,
    @required this.catName,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(singleCategoryScreen, arguments: {
          "id": id,
          "category": catName,
        });
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              imageUrl,
            ),
            // backgroundColor: catMap[index]["color"],
          ),
          Text(
            catName,
            style: TextStyle(fontSize: 13),
          ),
        ],
      ),
    );
  }
}
