import 'package:flutter/material.dart';

class CartCounter extends StatefulWidget {
  static int qty = 1;
  final double countStock;

  CartCounter(this.countStock);

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  // int numOfItem = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          BuildOutlinedButton(
            icon: Icons.remove,
            press: () {
              if (CartCounter.qty > 1) {
                setState(() {
                  CartCounter.qty--;
                });
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              CartCounter.qty.toString().padLeft(2, "0"),
            ),
          ),
          BuildOutlinedButton(
            icon: Icons.add,
            press: () {
              if (CartCounter.qty < widget.countStock) {
                setState(() {
                  CartCounter.qty++;
                });
              }
            },
          ),
        ],
      ),
    );
  }
}

class BuildOutlinedButton extends StatelessWidget {
  final IconData icon;
  final Function press;

  BuildOutlinedButton({
    @required this.icon,
    @required this.press,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      width: 40,
      child: OutlinedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            EdgeInsets.zero,
          ),
        ),
        onPressed: press,
        child: Icon(
          icon,
          color: Colors.black,
        ),
      ),
    );
  }
}
