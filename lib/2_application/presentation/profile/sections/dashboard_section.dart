import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/app_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_list_card.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/profile/widgets/profile_section.dart';

class DashboardSection extends StatelessWidget {
  const DashboardSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    
    return ProfileSection(
      title: IntlHelper.dashboard.tr,
      appListCards: [
        ProfileSwitchListCard(
          title: IntlHelper.savedCameras.tr,
          value: controller.isSavedCamerasActive,
        ),
        ProfileSwitchListCard(
          title: IntlHelper.cardCamerasTitle.tr,
          value: controller.isExploreCamerasActive,
        ),
        ProfileSwitchListCard(
          title: IntlHelper.cardWidgetsTitle.tr,
          value: controller.isHomeWidgetsActive,
        ),
      ],
    );
  }
}