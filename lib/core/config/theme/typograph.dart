import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Typograph {
  static TextStyle globalFontStyle = GoogleFonts.poppins(
    letterSpacing: 0,
  );

  static TextStyle getStyle(
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  ) {
    return GoogleFonts.dmSans(
      color: color ?? Colors.black,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: 0,
    );
  }
}
