import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TraffEyeAppTheme {
  TraffEyeAppTheme._();

  // *****************
  // static colors
  // *****************
  static const Color _lightPrimaryColor = Color(0xFF143A62);
  static const Color _lightPrimaryVariantColor = Color(0xFF0F2A48);
  static const Color _lightOnPrimaryColor = Color(0xFFF8F8F8);
  static const Color _lightOnBackgroundColor = Color(0xFF1A1A1A);
  static const Color _lightAppBarColor = _lightPrimaryColor;
  static const Color _lightIconColor = Color(0xFFA5FFFF);
  static const Color _lightAccentColor = Color(0xFFFFC08A);
  static const Color _lightAccentVariantColor = Color(0xFFFF9840);
  static const Color _lightBackgroundColor = Color(0xFFF8F8F8);

  static const Color _lightCaptionColor = Color(0xFF7D7D7D);
  static const Color _lightDisableColor = Color(0xFFB6B6B6);
  static const Color _lightHintColor = Color(0xFF9E9E9E);

  static const Color _lightPositiveColor = Color(0xFF6DBB61);
  static const Color _lightNegativeColor = Color(0xFFCB4444);

  static final TextStyle _baseTextStyle = GoogleFonts.montserrat();

  // *****************
  // Text Style - light
  // *****************

  static final TextStyle _lightDisplayText = _baseTextStyle.copyWith(
    color: _lightOnBackgroundColor,
    fontSize: 21,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle _lightTitleText = _baseTextStyle.copyWith(
    color: _lightOnBackgroundColor,
    fontSize: 17,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle _lightBodyText = _baseTextStyle.copyWith(
    color: _lightOnBackgroundColor,
    fontWeight: FontWeight.w400,
    fontSize: 15,
  );

  static final TextStyle _lightCaptionText = _baseTextStyle.copyWith(
    color: _lightCaptionColor,
    fontWeight: FontWeight.w400,
    fontSize: 13,
  );

  static final TextTheme _lightTextTheme = TextTheme(
    displayLarge: _lightDisplayText,
    titleLarge: _lightTitleText,
    bodyLarge: _lightBodyText,
    bodySmall: _lightCaptionText,
  );

  // *****************
  // Theme light/dark
  // *****************

  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightPrimaryColor,
    appBarTheme: const AppBarTheme(
      color: _lightAppBarColor,
      iconTheme: IconThemeData(color: _lightIconColor),
    ),
    colorScheme: const ColorScheme.light(
      background: _lightBackgroundColor,
      onBackground: _lightOnBackgroundColor,
      primary: _lightPrimaryColor,
      onPrimary: _lightOnPrimaryColor,
      secondary: _lightIconColor,
      tertiary: _lightAccentColor,
      tertiaryContainer: _lightAccentVariantColor,
      primaryContainer: _lightPrimaryVariantColor,
    ),
    textTheme: _lightTextTheme,
    bottomAppBarTheme: const BottomAppBarTheme(color: _lightAppBarColor),
  );

  Color getPositiveColor(bool isDarkTheme) {
    return isDarkTheme ? _lightPositiveColor : _lightPositiveColor;
  }

  Color getNegativeColor(bool isDarkTheme) {
    return isDarkTheme ? _lightNegativeColor : _lightNegativeColor;
  }

  Color getDisableColor(bool isDarkTheme) {
    return isDarkTheme ? _lightDisableColor : _lightDisableColor;
  }

  Color getHintColor(bool isDarkTheme) {
    return isDarkTheme ? _lightHintColor : _lightHintColor;
  }
}
