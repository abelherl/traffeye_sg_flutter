import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:traffeye_sg_flutter/2_application/controllers/camera_controller.dart';
import 'package:traffeye_sg_flutter/2_application/core/helpers/assets_path_helper.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/bot_nav/widgets/app_bot_nav_bar.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/bot_nav/widgets/fade_indexed_stack.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/dashboard/dashboard_page.dart';

import 'widgets/app_floating_action_button.dart';

class BotNavPage extends StatelessWidget {
  const BotNavPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: const FadeIndexedStack(
        index: 0,
        children: [
          DashboardPage(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: const AppFloatingActionButton(),
      bottomNavigationBar: AppBotNavBar(
        onTap: (index) {
          print('Test');
        },
      ),
    );
  }
}
