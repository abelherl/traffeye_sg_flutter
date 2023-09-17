import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class StyleHelper {
  static double radiusSmall = 8.r;
  static double radiusBig = 16.r;
  static BorderRadius borderRadiusSmall = BorderRadius.circular(radiusSmall);
  static BorderRadius borderRadiusBig = BorderRadius.circular(radiusBig);
  static const double ratioCarousel = 328 / 190;
  static const double ratioGrid = 156 / 110;
  static const double ratioList = 328 / 150;
}