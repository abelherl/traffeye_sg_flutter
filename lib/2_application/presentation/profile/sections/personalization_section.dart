import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/app_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_list_card.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/profile/pages/dashboard_layout/dashboard_layout_details_page.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/profile/pages/home_widgets/home_widgets_details_page.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/profile/widgets/profile_section.dart';

class PersonalizationSection extends StatelessWidget {
  const PersonalizationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();

    return ProfileSection(
      title: IntlHelper.personalization.tr,
      appListCards: [
        ProfileBasicListCard(
          title: IntlHelper.cardWidgetsTitle.tr,
          onPressed: () => Get.to(const HomeWidgetsDetails()),
        ),
        Obx(
          () => ProfileBasicListCard(
            title: IntlHelper.dashboardLayout.tr,
            suffix: controller.selectedDashboardLayout.value.name,
            onPressed: () => Get.to(const DashboardLayoutDetails()),
          ),
        ),
      ],
    );
  }
}