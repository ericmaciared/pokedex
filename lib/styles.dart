import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static double mainPadding = 33;
  static double sidePadding = 10;
  static Color mainGray = Color.fromRGBO(157, 157, 157, 1.0);


  // TODO Refactor into new component
  static Text H1(String text, Color color) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        color: color,
        fontSize: 36,
      )
    );
  }

  static Text H3(String text, Color color) {
    return Text(
        text,
        style: GoogleFonts.poppins(
          color: color,
          fontSize: 22,
        )
    );
  }

  static Text H4(String text, Color color) {
    return Text(
        text,
        style: GoogleFonts.poppins(
          color: color,
          fontSize: 16,
        )
    );
  }

  static Text H5(String text, Color color) {
    return Text(
        text,
        style: GoogleFonts.poppins(
          color: color,
          fontSize: 14,
        )
    );
  }

}
