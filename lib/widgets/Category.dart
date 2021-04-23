import 'package:anybuy/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String catName;

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
      child: Container(
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              color2,
              color1,
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
              softWrap: true,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
