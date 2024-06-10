import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyThemeData {
  static ColorScheme lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff000000),
    onPrimary: Color(0xfff5f5f5),
    primaryContainer: Color(0xff5A7BC5),
    onPrimaryContainer: Color(0xffffffff),
    secondary: Color(0xff091434),
    onSecondary: Color(0xffCED8EE),
    error: Color(0xffff2e00),
    onError: Color(0xfffafafa),
    surface: Color(0xfff9f9f9),
    onSurface: Color(0xff000000),
    surfaceTint: Color(0xfffef7ff),
    outline: Color(0xff000000),
    outlineVariant: Color(0xffe6e6e6),
    background: Colors.white,
    onBackground: Colors.white,
  );
  static ColorScheme darkColorScheme = ColorScheme(
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
    surfaceTint: Color(0xffffffff),
    outline: Color(0xff000000),
    outlineVariant: Color(0xffe6e6e6),
    background: Colors.black,
    onBackground: Colors.black,
  );

  static ThemeData lightTheme = ThemeData().copyWith(
    colorScheme: lightColorScheme,
    brightness: Brightness.light,
    textTheme: TextTheme().copyWith(
      displayLarge: GoogleFonts.montserrat(
        textStyle: TextStyle(
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
          fontWeight: FontWeight.w600,
          fontSize: 36,
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
          fontWeight: FontWeight.w700,
          fontSize: 25,
          shadows: [
            // Shadow(
            //   blurRadius: 4.0,
            //   offset: Offset(0, 4.0),
            //   color: Colors.black.withOpacity(0.25),
            // )
          ],
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
          fontWeight: FontWeight.w600,
          fontSize: 16,
        ),
      ),
      bodyLarge: GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
      ),
      bodyMedium: GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 15,
        ),
      ),
      bodySmall: GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 10,
          color: Colors.black
        ),
      ),
      labelLarge: GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
      labelMedium: GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      labelSmall: GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
        ),
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(brightness: Brightness.dark);
}
