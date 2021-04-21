import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Categories extends StatelessWidget {
  static List<Map<String, dynamic>> catMap = [
    {
      "id": Uuid().v4(),
      "image":
          "https://www.pngkit.com/png/detail/366-3665671_restaurant-meal-food-clipart-transparent-background.png",
      "category": "Restaurants"
    },
    {
      "id": Uuid().v4(),
      "image":
          "https://library.kissclipart.com/20190916/wgq/kissclipart-clip-art-toy-stationery-f3217c38ff505a8b.png",
      "category": "Stationaries"
    },
    {
      "id": Uuid().v4(),
      "image":
          "https://www.clipartkey.com/mpngs/m/60-609806_transparent-grocery-store-clip-art.png",
      "category": "Grocery"
    },
    {
      "id": Uuid().v4(),
      "image":
          "https://www.clipartmax.com/png/middle/2-23553_medicine-icon-medicine-clipart.png",
      "category": "Medicines"
    },
    {
      "id": Uuid().v4(),
      "image":
          "https://thumbs.dreamstime.com/b/supermarket-facade-people-shopping-product-hypermarket-grocery-food-store-male-female-buyers-vector-background-153201502.jpg",
      "category": "Hypermarts"
    },
    {
      "id": Uuid().v4(),
      "image": "https://webstockreview.net/images/dairy-clipart-15.jpg",
      "category": "Dairy"
    },
    {
      "id": Uuid().v4(),
      "image":
          "https://i.pinimg.com/originals/e0/38/7b/e0387b9c6cc7a269ba92f92f8b8321ac.png",
      "category": "Sports"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 50,
        maxHeight: 100,
      ),
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 8.0,
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    catMap[index]["image"],
                  ),
                  // backgroundColor: catMap[index]["color"],
                ),
                Text(
                  catMap[index]["category"],
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
          );
        },
        itemCount: 7,
      ),
    );
  }
}
