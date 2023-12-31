import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTheme {
  // * Static Colors - Light
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

  // * Public Colors
  static const Color positiveColor = Color(0xFF6DBB61);
  static const Color negativeColor = Color(0xFFCB4444);
  static const Color lightCaptionColor = Color(0xFF7D7D7D);
  static const Color lightDisableColor = Color(0xFFB6B6B6);
  static const Color lightHintColor = Color(0xFF9E9E9E);
  static final Color negativeSplashColor = negativeColor.withOpacity(0.1);
  static final Color positiveSplashColor = positiveColor.withOpacity(0.1);
  static final Color imagesSplashColor = _lightAccentVariantColor.withOpacity(0.3);
  static final Color barrierColor = _lightPrimaryColor.withOpacity(0.5);

  // * Text Style - Light
  static final TextStyle _lightDisplayText = GoogleFonts.montserrat(
    color: _lightOnBackgroundColor,
    fontSize: 21.sp,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle _lightTitleText = GoogleFonts.montserrat(
    color: _lightPrimaryColor,
    fontSize: 17.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  static final TextStyle _lightBodyText = GoogleFonts.montserrat(
    color: _lightOnBackgroundColor,
    fontWeight: FontWeight.w400,
    fontSize: 15.sp,
    letterSpacing: 0,
  );

  static final TextStyle _lightCaptionText = GoogleFonts.montserrat(
    color: _lightCaptionColor,
    fontWeight: FontWeight.w400,
    fontSize: 13.sp,
    letterSpacing: 0,
  );

  static final TextStyle _lightLabelText = GoogleFonts.montserrat(
    color: _lightPrimaryColor,
    fontSize: 13.sp,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
  );

  static final TextTheme _lightTextTheme = TextTheme(
    displayLarge: _lightDisplayText,
    titleLarge: _lightTitleText,
    labelLarge: _lightLabelText,
    labelSmall: _lightCaptionText,
    bodyLarge: _lightBodyText,
  );

  // * Theme
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
}
