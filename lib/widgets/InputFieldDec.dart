import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InputDecoration inpDec(
  String hintText,
  String labelText, {
  bool isSearch = false,
}) {
  return InputDecoration(
    hintText: hintText,
    labelText: labelText,
    labelStyle: GoogleFonts.poppins(),
    prefixIcon: isSearch
        ? Icon(
            Icons.search,
            color: Colors.black38,
          )
        : null,
    hintStyle: GoogleFonts.poppins(fontSize: 13),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: Colors.tealAccent),
    ),
  );
}
