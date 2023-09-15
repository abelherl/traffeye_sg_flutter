import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_list_card.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/profile/widgets/profile_section.dart';

class DashboardSection extends StatelessWidget {
  const DashboardSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ProfileSection(
      title: IntlHelper.dashboard.tr,
      appListCards: [
        AppListCard.profileSwitch(
          title: IntlHelper.savedCameras.tr,
          value: Get.find<CameraController>().isHideRefreshButton,
        ),
        AppListCard.profileSwitch(
          title: IntlHelper.cardCamerasTitle.tr,
          value: Get.find<CameraController>().isHideRefreshButton,
        ),
        AppListCard.profileSwitch(
          title: IntlHelper.homeWidgetsTitle.tr,
          value: Get.find<CameraController>().isHideRefreshButton,
        ),
      ],
    );
  }
}