import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData().copyWith(
  brightness: Brightness.light,
  textTheme: TextTheme().copyWith(
    labelMedium: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 25,
        // height: 30,
      ),
    ),
    titleLarge: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 40,
        // height: 48,
      ),
    ),
    titleMedium: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w600,
        fontSize: 25,
        // height: 30,
      ),
    ),
    titleSmall: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    ),
  ),
);
ThemeData darkTheme = ThemeData(brightness: Brightness.dark);
