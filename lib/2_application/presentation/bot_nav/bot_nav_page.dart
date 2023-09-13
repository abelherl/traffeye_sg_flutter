import 'package:flutter/material.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/bot_nav/widgets/app_bot_nav_bar.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/bot_nav/widgets/fade_indexed_stack.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/dashboard/dashboard_page.dart';
import 'package:traffeye_sg_flutter/2_application/presentation/saved_cameras/saved_cameras_page.dart';

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
          SavedCamerasPage(),
          Placeholder(),
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
