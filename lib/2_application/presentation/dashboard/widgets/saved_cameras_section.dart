import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/app_controller.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/dashboard/widgets/carousel/camera_carousel_view.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/dashboard/widgets/grid/camera_grid_view.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/dashboard/widgets/list/camera_list_view.dart';
import 'package:traffeye_sg_flutter/2_application/widgets/themed_text.dart';

class SavedCamerasSection extends StatelessWidget {
  const SavedCamerasSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();
    final cameraController = Get.find<CameraController>();

    return Obx(
      () {
        if (!appController.isSavedCamerasActive.value) {
          return Container();
        }

        late final Widget dashboardLayout = _getDashboardLayout();

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
            dashboardLayout,
            SizedBox(height: 24.w),
          ],
        );
      }
    );
  }

  Widget _getDashboardLayout() {
    final appController = Get.find<AppController>();

    switch (appController.selectedDashboardLayout.value) {
      case (DashboardLayout.list):
        return const CameraListView();
      case (DashboardLayout.grid):
        return const CameraGridView();
      default:
        return const CameraCarouselView();
    }
  }
}
