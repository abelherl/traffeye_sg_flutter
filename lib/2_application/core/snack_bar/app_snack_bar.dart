import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/snack_bar/app_snack_bar_data.dart';
import 'package:traffeye_sg_flutter/theme.dart';

abstract class AppSnackBar {
  static final _colorScheme = AppTheme.lightTheme.colorScheme;

  static void showSnackBar(AppSnackBarData data) {
    Get.snackbar(
      data.title,
      data.message,
      backgroundColor: _colorScheme.primary,
      overlayColor: AppTheme.barrierColor,
      colorText: Colors.white,
      overlayBlur: 5,
      snackPosition: SnackPosition.BOTTOM,
      animationDuration: const Duration(milliseconds: 400),
      icon: SvgPicture.asset(
        AssetsPathHelper.filledWarning,
        colorFilter: ColorFilter.mode(
          _colorScheme.secondary,
          BlendMode.srcIn,
        ),
        height: 24.w,
        width: 24.w,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.w,
      ),
      margin: EdgeInsets.all(16.w),
    );
  }
}
