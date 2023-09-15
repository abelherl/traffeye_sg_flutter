import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/bot_nav_controller.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/bot_nav/widgets/app_bot_nav_bar.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/dashboard/dashboard_page.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/profile/profile_page.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/saved_cameras/saved_cameras_page.dart';

import 'widgets/app_floating_action_button.dart';

class BotNavPage extends StatelessWidget {
  const BotNavPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BotNavController());

    return Scaffold(
      extendBody: true,
      body: Obx(
        () => IndexedStack(
          index: controller.index.value,
          children: const [
            DashboardPage(),
            SavedCamerasPage(),
            ProfilePage(),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: const AppFloatingActionButton(),
      bottomNavigationBar: AppBotNavBar(
        onTap: controller.changeIndexTo,
      ),
    );
  }
}
