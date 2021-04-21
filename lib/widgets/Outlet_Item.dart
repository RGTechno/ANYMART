import 'package:flutter/material.dart';

import '../constants.dart';

class OutletItem extends StatelessWidget {
  final String id;
  final String outletName;

  OutletItem({
    @required this.outletName,
    @required this.id,
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
      child: Container(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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
              height: 150,
              margin: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
            ),
            Positioned(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  outletName,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              ),
              right: 10,
              bottom: 10,
            ),
          ],
        ),
      ),
    );
  }
}
