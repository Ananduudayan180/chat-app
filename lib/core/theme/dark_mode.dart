import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkMode = ThemeData(
  textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: Colors.white),
  scaffoldBackgroundColor: const Color(0xFF1A1A1A),
   iconTheme: IconThemeData(color: Colors.white),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFFFF7700),
    surface: Colors.white10,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.white70),
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: Color(0xFF2C2C2C),
    contentTextStyle: GoogleFonts.poppins(color: Color(0xFFFFFFFF)),
  ),
  dividerColor: Colors.white54,
);
