import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static double mainPadding = 33;
  static double sidePadding = 20;

  static Text H1(String text) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: Colors.black,
        fontSize: 36,
      )
    );
  }
}
