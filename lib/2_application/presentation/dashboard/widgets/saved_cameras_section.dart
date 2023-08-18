import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/app_controller.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/dashboard/widgets/carousel_view.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';

class SavedCamerasSection extends StatelessWidget {
  const SavedCamerasSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();
    final cameraController = Get.find<CameraController>();

    if (!appController.isSavedCamerasActive) {
      return Container();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ThemedText(
                IntlHelper.savedCameras.tr,
                themedTextStyle: ThemedTextStyle.title,
              ),
              Obx(
                () => ThemedText(
                  cameraController.lastUpdatedString.value,
                  themedTextStyle: ThemedTextStyle.caption,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.w),
        const CarouselView(),
      ],
    );
  }
}
