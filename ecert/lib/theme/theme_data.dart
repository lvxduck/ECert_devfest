import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTheme {
  CustomTheme._();

  static const Color _lightFillColor = Colors.black;
  static const Color _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);

  static ThemeData lightThemeData = themeData(lightColorScheme, _lightFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      // Matches manifest.json colors and background color.
      primaryColor: const Color(0xFF030303),
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.background,
        elevation: 0,
        iconTheme: IconThemeData(color: colorScheme.primary),
      ),
      iconTheme: IconThemeData(color: colorScheme.onPrimary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: focusColor,
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.subtitle1?.apply(color: _darkFillColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(126, 48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)),
        hintStyle: TextStyle(color: Colors.grey[400]),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
      ),
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color(0xff0B66BF),
    primaryVariant: Color(0xff0B66BF),
    secondary: Color(0xff0B66BF),
    secondaryVariant: Color(0xff0B66BF),
    background: Color(0xFFFFFFFF),
    surface: Color(0xffF4F7FB),
    onBackground: Color(0xff334D6E),
    error: Color(0xFFB00020), //E12B2B
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Color(0xff334D6E),
    brightness: Brightness.light,
  );

  static const FontWeight _regular = FontWeight.w400;
  static const FontWeight _medium = FontWeight.w500;
  static const FontWeight _semiBold = FontWeight.w600;
  static const FontWeight _bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    headline3: GoogleFonts.roboto(fontWeight: _bold, fontSize: 32.0, color: Colors.black),
    headline4: GoogleFonts.roboto(fontWeight: _bold, fontSize: 20.0, color: Colors.black),
    headline5: GoogleFonts.roboto(fontWeight: _medium, fontSize: 16.0),
    headline6: GoogleFonts.roboto(fontWeight: _bold, fontSize: 16.0),
    caption: GoogleFonts.roboto(fontWeight: _semiBold, fontSize: 16.0),
    overline: GoogleFonts.roboto(fontWeight: _medium, fontSize: 12.0),
    bodyText1: GoogleFonts.roboto(fontWeight: _regular, fontSize: 14.0),
    subtitle1: GoogleFonts.roboto(fontWeight: _medium, fontSize: 16.0),
    bodyText2: GoogleFonts.roboto(fontWeight: _regular, fontSize: 16.0, color: Colors.black),
    subtitle2: GoogleFonts.roboto(fontWeight: _medium, fontSize: 14.0),
    button: GoogleFonts.roboto(fontWeight: _semiBold, fontSize: 18.0),
  );
}
