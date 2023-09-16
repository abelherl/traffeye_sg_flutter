import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/app_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_list_card.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/profile/pages/dashboard_layout/change_layout_page.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/profile/widgets/profile_details_page.dart';

class DashboardLayoutDetails extends StatelessWidget {
  const DashboardLayoutDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();

    return Obx(
      () => ProfileDetailsPage(
        pageTitle: IntlHelper.dashboardLayout.tr,
        title: IntlHelper.dashboardLayoutTitle.tr,
        description: IntlHelper.dashboardLayoutTexts.tr,
        cards: [
          ProfileBasicListCard(
            title: IntlHelper.dashboardLayoutButton.tr,
            suffix: controller.selectedDashboardLayout.value.name,
            onPressed: () => Get.to(const ChangeLayoutPage()),
          )
        ],
      ),
    );
  }
}
