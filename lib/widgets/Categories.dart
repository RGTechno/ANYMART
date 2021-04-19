import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Categories extends StatelessWidget {
  static List<Map<String, dynamic>> catMap = [
    {
      "image":
          "https://www.pngkit.com/png/detail/366-3665671_restaurant-meal-food-clipart-transparent-background.png",
      "category": "Restaurants"
    },
    {
      "image":
          "https://library.kissclipart.com/20190916/wgq/kissclipart-clip-art-toy-stationery-f3217c38ff505a8b.png",
      "category": "Stationaries"
    },
    {
      "image":
          "https://www.clipartkey.com/mpngs/m/60-609806_transparent-grocery-store-clip-art.png",
      "category": "Grocery"
    },
    {
      "image":
          "https://www.clipartmax.com/png/middle/2-23553_medicine-icon-medicine-clipart.png",
      "category": "Medicines"
    },
    {
      "image":
          "https://thumbs.dreamstime.com/b/supermarket-facade-people-shopping-product-hypermarket-grocery-food-store-male-female-buyers-vector-background-153201502.jpg",
      "category": "Hypermarts"
    },
    {
      "image": "https://webstockreview.net/images/dairy-clipart-15.jpg",
      "category": "Dairy"
    },
    {
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
