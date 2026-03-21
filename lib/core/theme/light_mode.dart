import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightMode = ThemeData(
  textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.grey[900]),
  scaffoldBackgroundColor: const Color(0xFFF2F2F2),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFFFF7700),
    surface: Colors.white,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.grey[600]),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Color(0xFFE0E0E0),
    contentTextStyle: GoogleFonts.poppins(color: Color(0xFF000000)),
  ),
  dividerColor: Colors.black38,
);
