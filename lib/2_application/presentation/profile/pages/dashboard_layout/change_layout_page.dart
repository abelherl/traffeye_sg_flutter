import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/app_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/intl_helper.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/app_list_card.dart';
import 'package:traffeye_sg_flutter/2_application/core/widgets/themed_app_bar.dart';

class ChangeLayoutPage extends StatelessWidget {
  const ChangeLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AppController>();
    final layouts = DashboardLayout.values.toList();

    return Scaffold(
      appBar: ThemedAppBar(
        title: IntlHelper.dashboardLayoutButton.tr,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: ListView.builder(
        itemCount: layouts.length,
        itemBuilder: (_, index) {
          final layout = layouts[index];
          return Obx(
            () => ProfileSelectedListCard(
              title: layout.name,
              isSelected: controller.selectedDashboardLayout.value == layout,
              onPressed: () => controller.changeDashboardLayoutTo(layout),
            ),
          );
        },
      ),
    );
  }
}
