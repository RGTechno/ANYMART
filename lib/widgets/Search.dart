import 'package:anybuy/widgets/InputFieldDec.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8.0),
      child: TextField(
        decoration: inpDec(
          "Search Through Categories",
          "Search",
          isSearch: true,
        ),
      ),
    );
  }
}
