import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/bot_nav_controller.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/bot_nav/widgets/app_bot_nav_bar.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/dashboard/dashboard_page.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/profile/profile_page.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/saved_cameras/saved_cameras_page.dart';

import 'widgets/app_floating_action_button.dart';

class BotNavPage extends StatelessWidget {
  const BotNavPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final botNavController = Get.put(BotNavController());
    final cameraController = Get.find<CameraController>();

    return Obx(
      () {
        final isEnableRefreshButton = botNavController.index.value == 0 &&
            !cameraController.isHideRefreshButton.value;

        return Scaffold(
          extendBody: true,
          body: IndexedStack(
            index: botNavController.index.value,
            children: const [
              DashboardPage(),
              SavedCamerasPage(),
              ProfilePage(),
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          floatingActionButton:
              isEnableRefreshButton ? const AppFloatingActionButton() : null,
          bottomNavigationBar: AppBotNavBar(
            onTap: botNavController.changeIndexTo,
          ),
        );
      },
    );
  }
}
