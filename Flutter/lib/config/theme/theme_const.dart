import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xfff5f5f5),
  onPrimary: Color(0xff000000),
  primaryContainer: Color(0xff5A7BC5),
  onPrimaryContainer: Color(0xffffffff),
  secondary: Color(0xffCED8EE),
  onSecondary: Color(0xff091434),
  error: Color(0xffff2e00),
  onError: Color(0xfffafafa),
  surface: Color(0xfff9f9f9),
  onSurface: Color(0xff000000),
  surfaceVariant: Color(0xffffffff),
  outline: Color(0xff000000),
  outlineVariant: Color(0xffe6e6e6),
  surfaceTint: Color(0xffdcdcdc), background: Colors.black, onBackground: Colors.black,
);
ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xfff5f5f5),
  onPrimary: Color(0xff091434),
  primaryContainer: Color(0xff5A7BC5),
  onPrimaryContainer: Color(0xffffffff),
  secondary: Color(0xffCED8EE),
  onSecondary: Color(0xff091434),
  error: Color(0xffff2e00),
  onError: Color(0xfffafafa),
  surface: Color(0xfff9f9f9),
  onSurface: Color(0xff000000),
  surfaceVariant: Color(0xffffffff),
  outline: Color(0xff000000),
  outlineVariant: Color(0xffe6e6e6),
  surfaceTint: Color(0xffdcdcdc), background: Colors.white
  , onBackground: Colors.white,
);

ThemeData lightTheme = ThemeData().copyWith(
  colorScheme: lightColorScheme,
  brightness: Brightness.light,
  textTheme: TextTheme().copyWith(
    labelMedium: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 25,
      ),
    ),
    labelSmall: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: lightColorScheme.onSecondary,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    ),
    displayLarge: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 40,
        shadows: [
          Shadow(
            blurRadius: 4.0,
            offset: Offset(0, 4.0),
            color: Colors.black.withOpacity(0.25),
          )
        ],
      ),
    ),
    displayMedium: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 25,
        shadows: [
          Shadow(
            blurRadius: 4.0,
            offset: Offset(0, 4.0),
            color: Colors.black.withOpacity(0.25),
          )
        ],
      ),
    ),
    displaySmall: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
    ),
    headlineLarge: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: lightColorScheme.primaryContainer,
        fontWeight: FontWeight.w600,
        fontSize: 36,
      ),
    ),
    headlineSmall: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: lightColorScheme.onPrimary,
        fontWeight: FontWeight.w600,
        fontSize: 16,
      ),
    ),
    bodySmall: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: lightColorScheme.onPrimary,
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
    ),
     bodyMedium: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 14,
      )),
      bodyLarge: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
    ),
  ),
);
ThemeData darkTheme = ThemeData(brightness: Brightness.dark);
