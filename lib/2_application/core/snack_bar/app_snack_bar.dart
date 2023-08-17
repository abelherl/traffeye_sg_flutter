import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/core/snack_bar/app_snack_bar_data.dart';

abstract class AppSnackBar {
  static void showSnackBar(AppSnackBarData data) {
    Get.snackbar(data.title, data.message);
  }
}
