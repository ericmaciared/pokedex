import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static const double mainPadding = 33;
  static const double sidePadding = 10;
  static const Color mainGray = Color.fromRGBO(157, 157, 157, 1.0);
  static const Color secondaryGray = Color.fromRGBO(217, 217, 217, 1.0);
  static const Color tertiaryGray = Color.fromRGBO(245, 245, 248, 1.0);

  static TextField baseTextField(String label, String hint) {
    return TextField(
        obscureText: true,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(),
          labelText: label,
          hintText: hint,
        ));
  }

  static Text H1(String text, Color color) {
    return Text(text,
        style: GoogleFonts.poppins(
          color: color,
          fontSize: 36,
        ));
  }

  static Text H3(String text, Color color) {
    return Text(text,
        style: GoogleFonts.poppins(
          color: color,
          fontSize: 22,
        ));
  }

  static Text H4(String text, Color color) {
    return Text(text,
        style: GoogleFonts.poppins(
          color: color,
          fontSize: 16,
        ));
  }

  static Text H5(String text, Color color) {
    return Text(text,
        style: GoogleFonts.poppins(
          color: color,
          fontSize: 14,
        ));
  }
}
