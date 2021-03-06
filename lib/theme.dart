import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuadernoTheme {
  static ThemeData get themeData {
    final ThemeData theme = ThemeData();
    return theme.copyWith(
      primaryColor: Colors.green,
      accentColor: Colors.amber,
      colorScheme: theme.colorScheme.copyWith(
        primary: Colors.green,
        secondary: Colors.amber,
      ),
      textTheme: GoogleFonts.latoTextTheme(),
      iconTheme: theme.iconTheme.copyWith(),
    );
  }
}
